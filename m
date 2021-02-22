Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A3F0321020
	for <lists+linux-arch@lfdr.de>; Mon, 22 Feb 2021 06:08:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbhBVFHC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 22 Feb 2021 00:07:02 -0500
Received: from m42-2.mailgun.net ([69.72.42.2]:23162 "EHLO m42-2.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229487AbhBVFHB (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 22 Feb 2021 00:07:01 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1613970396; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=4sOm7RL/GojtBTEv2KuW3oPf8DiE8mWjcTb6fFV7JV0=;
 b=q15w7TpKD3SuUgFUpZpjZTnjiwij77gbICqP1zUbgX92Z48RZxAwuOBl1/OWp2DDiybpfzYz
 1vSpl1aAuwkBXaoG9hvyzRXMZwrE3K4jWYRzHgR5tGd87+s9oUnhU1A7T61xM0MpDfOQQxDD
 DpyjWABcp1GI4TGJDButw4C0nFc=
X-Mailgun-Sending-Ip: 69.72.42.2
X-Mailgun-Sid: WyI5MDNlZiIsICJsaW51eC1hcmNoQHZnZXIua2VybmVsLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 60333bdbf33d74123f42aafe (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 22 Feb 2021 05:06:35
 GMT
Sender: pnagar=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 78FE0C4346A; Mon, 22 Feb 2021 05:06:34 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: pnagar)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 15FC2C433C6;
        Mon, 22 Feb 2021 05:06:33 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 22 Feb 2021 10:36:32 +0530
From:   pnagar@codeaurora.org
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, jmorris@namei.org, serge@hallyn.com,
        Paul Moore <paul@paul-moore.com>,
        stephen.smalley.work@gmail.com, Eric Paris <eparis@parisplace.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        selinux@vger.kernel.org, linux-arch <linux-arch@vger.kernel.org>,
        casey@schaufler-ca.com, Nick Desaulniers <ndesaulniers@google.com>,
        David Howells <dhowells@redhat.com>,
        Miguel Ojeda <ojeda@kernel.org>, psodagud@codeaurora.org,
        nmardana@codeaurora.org, Johan Hovold <johan@kernel.org>,
        Joe Perches <joe@perches.com>, Jessica Yu <jeyu@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] RTIC: selinux: ARM64: Move selinux_state to a separate
 page
In-Reply-To: <CANiq72=O0RaHVRcKFF_YDDO4xDFdxaGdH94PgvuibK-ZzHvOxA@mail.gmail.com>
References: <1613470672-3069-1-git-send-email-pnagar@codeaurora.org>
 <CANiq72=O0RaHVRcKFF_YDDO4xDFdxaGdH94PgvuibK-ZzHvOxA@mail.gmail.com>
Message-ID: <f6b1520b7712ef7cd248a8120badd061@codeaurora.org>
X-Sender: pnagar@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 2021-02-17 02:02, Miguel Ojeda wrote:
> On Tue, Feb 16, 2021 at 11:22 AM Preeti Nagar <pnagar@codeaurora.org> 
> wrote:
>> 
>> The changes introduce a new security feature, RunTime Integrity Check
>> (RTIC), designed to protect Linux Kernel at runtime. The motivation
>> behind these changes is:
>> 1. The system protection offered by Security Enhancements(SE) for
>> Android relies on the assumption of kernel integrity. If the kernel
>> itself is compromised (by a perhaps as yet unknown future 
>> vulnerability),
>> SE for Android security mechanisms could potentially be disabled and
>> rendered ineffective.
>> 2. Qualcomm Snapdragon devices use Secure Boot, which adds 
>> cryptographic
>> checks to each stage of the boot-up process, to assert the 
>> authenticity
>> of all secure software images that the device executes.  However, due 
>> to
>> various vulnerabilities in SW modules, the integrity of the system can 
>> be
>> compromised at any time after device boot-up, leading to un-authorized
>> SW executing.
>> 
>> The feature's idea is to move some sensitive kernel structures to a
>> separate page and monitor further any unauthorized changes to these,
>> from higher Exception Levels using stage 2 MMU. Moving these to a
>> different page will help avoid getting page faults from un-related 
>> data.
>> The mechanism we have been working on removes the write permissions 
>> for
>> HLOS in the stage 2 page tables for the regions to be monitored, such
>> that any modification attempts to these will lead to faults being
>> generated and handled by handlers. If the protected assets are moved 
>> to
>> a separate page, faults will be generated corresponding to change 
>> attempts
>> to these assets only. If not moved to a separate page, write attempts 
>> to
>> un-related data present on the monitored pages will also be generated.
>> 
>> Using this feature, some sensitive variables of the kernel which are
>> initialized after init or are updated rarely can also be protected 
>> from
>> simple overwrites and attacks trying to modify these.
>> 
>> Currently, the change moves selinux_state structure to a separate 
>> page.
>> The page is 2MB aligned not 4K to avoid TLB related performance impact 
>> as,
>> for some CPU core designs, the TLB does not cache 4K stage 2 (IPA to 
>> PA)
>> mappings if the IPA comes from a stage 1 mapping. In future, we plan 
>> to
>> move more security-related kernel assets to this page to enhance
>> protection.
> 
> Part of this commit message should likely be added as a new file under
> Documentation/ somewhere.
> 
Yes, that will be helpful, will put it in Documentation/security in the
next update. Thank you!

>> diff --git a/security/Kconfig b/security/Kconfig
>> index 7561f6f..1af913a 100644
>> --- a/security/Kconfig
>> +++ b/security/Kconfig
>> @@ -291,5 +291,16 @@ config LSM
>> 
>>  source "security/Kconfig.hardening"
>> 
>> +config SECURITY_RTIC
>> +       bool "RunTime Integrity Check feature"
>> +       depends on ARM64
>> +       help
>> +         RTIC(RunTime Integrity Check) feature is to protect Linux 
>> kernel
>> +         at runtime. This relocates some of the security sensitive 
>> kernel
>> +         structures to a separate RTIC specific page.
>> +
>> +         This is to enable monitoring and protection of these kernel 
>> assets
>> +         from a higher exception level(EL) against any unauthorized 
>> changes.
> 
> Rewording suggestion:
> 
>          The RTIC (RunTime Integrity Check) feature protects the kernel
>          at runtime by relocating some of its security-sensitive 
> structures
>          to a separate RTIC-specific page. This enables monitoring and
>          and protecting them from a higher exception level against
>          unauthorized changes.
> 
Thanks :)

> Cheers,
> Miguel
