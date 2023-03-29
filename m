Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B26286CD012
	for <lists+linux-arch@lfdr.de>; Wed, 29 Mar 2023 04:36:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbjC2Cgx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 28 Mar 2023 22:36:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbjC2Cgj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 28 Mar 2023 22:36:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B580230F1
        for <linux-arch@vger.kernel.org>; Tue, 28 Mar 2023 19:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680057347;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uk4XWZ2laUwaUBSfpuB6h6JbrXDzKovTQURHIz2YxOo=;
        b=FLDh3IHWpne8Aowdpn1XNXsqlKqxGcO+93XbDgyVftX1vjgULMxSRRYF5re0diC7r9DtB+
        SU1wgLovdPVxlZcdn4D9RJBD31+703KBzWSISxx1H4sAkSMbFayh/hN9aBbgUMOKC3ngcc
        tP+RjnqhiQtafSUkr70T49nqCLJ3xWk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-228-KlnEoq3DMH2x9S4ZkzV4HA-1; Tue, 28 Mar 2023 22:35:40 -0400
X-MC-Unique: KlnEoq3DMH2x9S4ZkzV4HA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C45E8801210;
        Wed, 29 Mar 2023 02:35:38 +0000 (UTC)
Received: from [10.72.13.230] (ovpn-13-230.pek2.redhat.com [10.72.13.230])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 66F4A140E96A;
        Wed, 29 Mar 2023 02:35:21 +0000 (UTC)
Reply-To: Gavin Shan <gshan@redhat.com>
Subject: Re: [RFC PATCH 00/32] ACPI/arm64: add support for virtual cpuhotplug
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
From:   Gavin Shan <gshan@redhat.com>
Message-ID: <41dd71ab-a6a7-fd93-73ec-64a6b0ca468e@redhat.com>
Date:   Wed, 29 Mar 2023 10:35:17 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20230203135043.409192-1-james.morse@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi James,

On 2/3/23 9:50 PM, James Morse wrote:

[...]

> 
> 
> The first patch has already been posted as a fix here:
> https://www.spinics.net/lists/linux-ia64/msg21920.html
> I've only build tested Loongarch and ia64.
> 

It has been merged to upstream.

> 
> If folk want to play along at home, you'll need a copy of Qemu that supports this.
> https://github.com/salil-mehta/qemu.git salil/virt-cpuhp-armv8/rfc-v1-port29092022.psci.present
> 
> You'll need to fix the numbers of KVM_CAP_ARM_HVC_TO_USER and KVM_CAP_ARM_PSCI_TO_USER
> to match your host kernel. Replace your '-smp' argument with something like:
> | -smp cpus=1,maxcpus=3,cores=3,threads=1,sockets=1
> 
> then feed the following to the Qemu montior;
> | (qemu) device_add driver=host-arm-cpu,core-id=1,id=cpu1
> | (qemu) device_del cpu1
> 
> 
> This series is based on v6.2-rc3, and can be retrieved from:
> https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git/ virtual_cpu_hotplug/rfc/v1
> 

I give it a try, but the hot-added CPU needs to be put into online
state manually. I'm not sure if it's expected or not.

     /home/gavin/sandbox/qemu.main/build/qemu-system-aarch64                \
     -accel kvm,dirty-ring-size=65536                                       \
     -machine virt,gic-version=host,nvdimm=on                               \
     -cpu host -smp maxcpus=8,cpus=1,sockets=1,clusters=1,cores=8,threads=1 \
     -m 1024M,slots=16,maxmem=64G                                           \
     -object memory-backend-ram,id=mem0,size=1024M                          \
     -numa node,nodeid=0,memdev=mem0                                        \
     -L /home/gavin/sandbox/qemu.main/build/pc-bios                         \
     -monitor none -serial mon:stdio -nographic -gdb tcp::1234              \
     -bios /home/gavin/sandbox/qemu.main/build/pc-bios/edk2-aarch64-code.fd \
     -kernel /home/gavin/sandbox/linux.guest/arch/arm64/boot/Image          \
     -initrd /home/gavin/sandbox/images/rootfs.cpio.xz                      \
     -append memhp_default_state=online_movable                             \
        :
        :
     guest# cat /proc/cpuinfo | grep "CPU implementer" | wc -l
     1
     (qemu) device_add driver=host-arm-cpu,core-id=1,id=cpu1
     guest# cat /proc/cpuinfo | grep "CPU implementer" | wc -l
     1
     guest# echo 1 > /sys/devices/system/cpu/cpu1/online
     guest# cat /proc/cpuinfo | grep "CPU implementer" | wc -l
     2
     (qemu) device_del cpu1
     guest# cat /proc/cpuinfo | grep "CPU implementer" | wc -l
     1

Note that the QEMU binary is directly built from Salil's repository and
the kernel image is built from v6.3-rc4, plus this patchset excluding the
first patch since it has been merged.

Thanks,
Gavin




