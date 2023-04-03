Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02CD36D3D4A
	for <lists+linux-arch@lfdr.de>; Mon,  3 Apr 2023 08:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231620AbjDCG0t (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 3 Apr 2023 02:26:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231576AbjDCG0s (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 3 Apr 2023 02:26:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4F26974F
        for <linux-arch@vger.kernel.org>; Sun,  2 Apr 2023 23:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680503160;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=afBNaZ0DMuI7GB+2iDCGbyFFwGSVdQ773bP8QWimT1I=;
        b=hVt84RZB1Lu91P0oGv2K24vng+TC4k4uSIffBfcZfn62oUIQoW4CZpkU+zWbVJr1rgB6+X
        c6o8jp3nKng/EC7jBdAvjVPxbBjnirMiYc1Gg8sJ1A2WniM3alfYAgmOSCMjL7GBgNgH5C
        xznGjOmUH1Ow6EM4awrGrZ0C+SmKQug=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-244-28z4qi46NM2VpjD3-hJMRQ-1; Mon, 03 Apr 2023 02:25:57 -0400
X-MC-Unique: 28z4qi46NM2VpjD3-hJMRQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0C99A801210;
        Mon,  3 Apr 2023 06:25:56 +0000 (UTC)
Received: from [10.72.12.158] (ovpn-12-158.pek2.redhat.com [10.72.12.158])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2D5BAC15BA0;
        Mon,  3 Apr 2023 06:25:40 +0000 (UTC)
Reply-To: Gavin Shan <gshan@redhat.com>
Subject: Re: [RFC PATCH 00/32] ACPI/arm64: add support for virtual cpuhotplug
To:     Shaoqin Huang <shahuang@redhat.com>,
        James Morse <james.morse@arm.com>, linux-pm@vger.kernel.org,
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
 <e17627fb-283e-dd42-94c1-f89dea167577@redhat.com>
From:   Gavin Shan <gshan@redhat.com>
Message-ID: <972ed7df-78cd-e02a-7376-78c806181b5f@redhat.com>
Date:   Mon, 3 Apr 2023 14:25:36 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <e17627fb-283e-dd42-94c1-f89dea167577@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.6 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Shaoqin,

On 3/29/23 1:52 PM, Shaoqin Huang wrote:
> On 2/3/23 21:50, James Morse wrote:

[...]

>>
>> The first patch has already been posted as a fix here:
>> https://www.spinics.net/lists/linux-ia64/msg21920.html
>> I've only build tested Loongarch and ia64.
>>
>>
>> If folk want to play along at home, you'll need a copy of Qemu that supports this.
>> https://github.com/salil-mehta/qemu.git salil/virt-cpuhp-armv8/rfc-v1-port29092022.psci.present
>>
>> You'll need to fix the numbers of KVM_CAP_ARM_HVC_TO_USER and KVM_CAP_ARM_PSCI_TO_USER
>> to match your host kernel. Replace your '-smp' argument with something like:
>> | -smp cpus=1,maxcpus=3,cores=3,threads=1,sockets=1
>>
>> then feed the following to the Qemu montior;
>> | (qemu) device_add driver=host-arm-cpu,core-id=1,id=cpu1
>> | (qemu) device_del cpu1
>>
>>
>> This series is based on v6.2-rc3, and can be retrieved from:
>> https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git/ virtual_cpu_hotplug/rfc/v1
> 
> I applied this patch series on v6.2-rc3 and using the QEMU cloned from the salil-mehta/qemu.git repo. But when I try to run the QEMU, it shows:
> 
> $ qemu-system-aarch64: -accel kvm: Failed to enable KVM_CAP_ARM_PSCI_TO_USER cap.
> 
> Here is the command I use:
> 
> $ qemu-system-aarch64
> -machine virt
> -bios /usr/share/qemu-efi-aarch64/QEMU_EFI.fd
> -accel kvm
> -m 4096
> -smp cpus=1,maxcpus=3,cores=3,threads=1,sockets=1
> -cpu host
> -qmp unix:./src.socket,server,nowait
> -hda ./XXX.qcow2
> -serial unix:./src.serial,server,nowait
> -monitor stdio
> 
> It seems something related to your notice: You'll need to fix the numbers of KVM_CAP_ARM_HVC_TO_USER and KVM_CAP_ARM_PSCI_TO_USER
> to match your host kernel.
> 
> But I'm not actually understand what should I fix, since I haven't review the patch series. Could you give me some more information? Maybe I'm doing something wrong.
> 

When the kernel is rebased to v6.2.rc3, the two capabilities are conflictsing
between QEMU and host kernel. Please adjust them like below and have a try:

In qemu/linux-headers/linux/kvm.h

#define KVM_CAP_ARM_HVC_TO_USER 250 /* TODO: as per linux 6.1-rc2 */
#define KVM_CAP_ARM_PSCI_TO_USER 251 /* TODO: as per linux 6.1-rc2 */

In linux/include/uapi/linux/kvm.h

#define KVM_CAP_ARM_HVC_TO_USER 250
#define KVM_CAP_ARM_PSCI_TO_USER 251

Thanks,
Gavin


