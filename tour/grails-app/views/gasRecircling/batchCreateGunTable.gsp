
<table>
    <thead>
        <tr>
            <th><g:message code="gasRecircling.gun.label" default="Gun" /></th>
        
            <th><g:message code="gasRecircling.volume.label" default="Volume" />(L)</th>
        
            <th>${message(code: 'gasRecircling.differAmount.label', default: 'Differ Amount')}‰</th>
        
            <th>${message(code: 'gasRecircling.description.label', default: 'Description')}</th>
        
        </tr>
    </thead>
    <tbody>
    <g:each in="${guns}" status="i" var="gun">
        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
        
            <td>${gun.gunNo}(${gun.tank.tankNo }罐-${gun.tank.gasType.title })</td>
        
            <td><g:textField name="gun_volume_${gun.id }"/></td>
        
            <td><g:textField name="gun_differAmount_${gun.id }"/></td>
        
            <td><g:textField name="gun_description_${gun.id }"/></td>
        
        </tr>
    </g:each>
    </tbody>
</table>
                <div class="buttons">
                    <span class="button"><g:submitButton name="create" class="save" value="${message(code: 'default.button.save.label', default: 'Create')}" onclick="return confirm('${message(code: 'default.button.save.confirm.message', default: 'Are you sure?')}');" /></span>
                </div>