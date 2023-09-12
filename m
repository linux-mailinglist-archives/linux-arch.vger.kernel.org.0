Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FA7D79DBFD
	for <lists+linux-arch@lfdr.de>; Wed, 13 Sep 2023 00:40:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237798AbjILWko (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 12 Sep 2023 18:40:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235041AbjILWko (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 12 Sep 2023 18:40:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CA77310F2
        for <linux-arch@vger.kernel.org>; Tue, 12 Sep 2023 15:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694558348;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Hw4dz052UmhVfzEQW7+Uflu1VFGZC1UKKB7LwcrU6Xs=;
        b=MvrVe0hy+BTUdvgmv5XYR9J31v/CXhR5LTixqQsZP/Dgq3P2MPw+CwUwsiybgH8AiCNmfX
        qT9k+OQ0zYYnLABn0nYWolO4BH+wmJ7avUunp3M7V9Dn2Dd3nrJUzC+rjNNdLsu46t5rip
        +RM+nzVmmzCHFaHHUTaSVqalBLt4HkA=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-360-jOas4ZuXPJim6lrLmA1N5A-1; Tue, 12 Sep 2023 18:39:06 -0400
X-MC-Unique: jOas4ZuXPJim6lrLmA1N5A-1
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-1c3ae44bbceso35790715ad.2
        for <linux-arch@vger.kernel.org>; Tue, 12 Sep 2023 15:39:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694558345; x=1695163145;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hw4dz052UmhVfzEQW7+Uflu1VFGZC1UKKB7LwcrU6Xs=;
        b=Abokg+OQLF1MOGeIK6rcH1RcOJp7Yi9xSCIII6UxhicYO5lJMhuBVqBJcPK4lkIees
         2wDuUR5WB2yEQ7FYiqpXQXGOA+UerKNQYYit1GLNd6GgJX6CXP4ZYHkQ81y4ELxL5sCb
         rkUGb9WFTM7VRpR8Yhd/h12WqjnYndI+CH+lygN0QHlvAt1PYN1gLBjgSS1AICFSN2eK
         5aZru830v3n5sbr1+jTeuXl2tkzv5Fz6skqmi3nCbc+3FWuz45z+NkfG5eFCSvQwcq7E
         9Zytg/OzeDAMV1ZnBRAjyshIDIX7oxoOF9EGWF3Lg7hbxyFG+V8TDOhji0tPsycQfaom
         ipxQ==
X-Gm-Message-State: AOJu0Yx6IfKtrjTmqPU+Rdn/xs83CPTA70qWFyKXFTJqturN/pazlK4O
        iQxvdLrrDvaEfb0K3t93sQPlQXVISdxvbO8YPLT+yIzwOIJ8e+l/HUEglg4LH/Nz8sCBIlZJ05i
        el7QCPZhNijeXEyCV9qkGOYMz4Bkkvw==
X-Received: by 2002:a17:903:41c4:b0:1c3:3cde:7b44 with SMTP id u4-20020a17090341c400b001c33cde7b44mr1269640ple.12.1694558344876;
        Tue, 12 Sep 2023 15:39:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHJXfeCtpozu/i9MX/Nb9C9D8rRf3TwAOO4AoonFr0CYCLCqxvZy3HNtrsprY+cWVaejgiLRA==
X-Received: by 2002:a17:903:41c4:b0:1c3:3cde:7b44 with SMTP id u4-20020a17090341c400b001c33cde7b44mr1269621ple.12.1694558344560;
        Tue, 12 Sep 2023 15:39:04 -0700 (PDT)
Received: from ?IPV6:2001:8003:e5b0:9f00:dbbc:1945:6e65:ec5? ([2001:8003:e5b0:9f00:dbbc:1945:6e65:ec5])
        by smtp.gmail.com with ESMTPSA id c10-20020a170902aa4a00b001c0af36dd64sm8964168plr.162.2023.09.12.15.38.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Sep 2023 15:39:03 -0700 (PDT)
Message-ID: <5a5fb237-c28b-d6b5-0425-8f8f0fe1ac79@redhat.com>
Date:   Wed, 13 Sep 2023 08:38:51 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [RFC PATCH 00/32] ACPI/arm64: add support for virtual cpuhotplug
Content-Language: en-US
To:     James Morse <james.morse@arm.com>, linux-pm@vger.kernel.org,
        loongarch@lists.linux.dev, kvmarm@lists.linux.dev,
        kvm@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        x86@kernel.org
Cc:     Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Borislav Petkov <bp@alien8.de>, H Peter Anvin <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Len Brown <lenb@kernel.org>,
        Rafael Wysocki <rafael@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Salil Mehta <salil.mehta@huawei.com>,
        Russell King <linux@armlinux.org.uk>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
References: <20230203135043.409192-1-james.morse@arm.com>
 <41dd71ab-a6a7-fd93-73ec-64a6b0ca468e@redhat.com>
 <1ca1fb8f-1dec-74a3-ee44-94609f6aba2c@arm.com>
From:   Gavin Shan <gshan@redhat.com>
In-Reply-To: <1ca1fb8f-1dec-74a3-ee44-94609f6aba2c@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


Hi James,

On 9/13/23 03:01, James Morse wrote:
> On 29/03/2023 03:35, Gavin Shan wrote:
>> On 2/3/23 9:50 PM, James Morse wrote:
> 
>>> If folk want to play along at home, you'll need a copy of Qemu that supports this.
>>> https://github.com/salil-mehta/qemu.git
>>> salil/virt-cpuhp-armv8/rfc-v1-port29092022.psci.present
>>>
>>> You'll need to fix the numbers of KVM_CAP_ARM_HVC_TO_USER and KVM_CAP_ARM_PSCI_TO_USER
>>> to match your host kernel. Replace your '-smp' argument with something like:
>>> | -smp cpus=1,maxcpus=3,cores=3,threads=1,sockets=1
>>>
>>> then feed the following to the Qemu montior;
>>> | (qemu) device_add driver=host-arm-cpu,core-id=1,id=cpu1
>>> | (qemu) device_del cpu1
>>>
>>>
>>> This series is based on v6.2-rc3, and can be retrieved from:
>>> https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git/ virtual_cpu_hotplug/rfc/v1
> 
>> I give it a try, but the hot-added CPU needs to be put into online
>> state manually. I'm not sure if it's expected or not.
> 
> This is expected. If you want the CPUs to be brought online automatically, you can add
> udev rules to do that.
> 

Yeah, I usually execute the following command to bring the CPU into online state,
after the vCPU is hot added by QMP command.

(qemu) device_add driver=host-arm-cpu,core-id=1,id=cpu1
guest# echo 1 > /sys/devices/system/cpu/cpux/online

James, the series was posted a while ago and do you have plan to respin
and post RFCv2 in near future? :)

Thanks,
Gavin

