Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBEA62F0CD8
	for <lists+linux-arch@lfdr.de>; Mon, 11 Jan 2021 07:26:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbhAKGZv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 11 Jan 2021 01:25:51 -0500
Received: from m43-15.mailgun.net ([69.72.43.15]:23756 "EHLO
        m43-15.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726202AbhAKGZu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 11 Jan 2021 01:25:50 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1610346330; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=Y66XF+Djddn7k3iYTGrUGms1lzGNsW9OD4rOjfjlTmE=;
 b=gxUJABem4zTBN0fixPajHivHuctt9ziFmo259nHuds0lG0liHS7/TNFW9astzAyETiKEiavC
 1uX4o+IdNKUTLfvwPVpG/RoMwhY4sYV7hN4riBDW1DJHDCCrsY1R1sBa/cquKtb1JvD6+Y8v
 T0/RWnr+8d82SzQnrcnonnAKOSc=
X-Mailgun-Sending-Ip: 69.72.43.15
X-Mailgun-Sid: WyI5MDNlZiIsICJsaW51eC1hcmNoQHZnZXIua2VybmVsLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 5ffbef59c88af06107e5d796 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 11 Jan 2021 06:25:29
 GMT
Sender: pnagar=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E99EDC43465; Mon, 11 Jan 2021 06:25:28 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: pnagar)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2BF48C433CA;
        Mon, 11 Jan 2021 06:25:28 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 11 Jan 2021 11:55:28 +0530
From:   pnagar@codeaurora.org
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, jmorris@namei.org, serge@hallyn.com,
        paul@paul-moore.com, stephen.smalley.work@gmail.com,
        eparis@parisplace.org,
        linux-security-module <linux-security-module@vger.kernel.org>,
        selinux@vger.kernel.org, linux-arch <linux-arch@vger.kernel.org>,
        psodagud@codeaurora.org, nmardana@codeaurora.org,
        dsule@codeaurora.org, Joe Perches <joe@perches.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Nick Desaulniers <ndesaulniers@gooogle.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v2] selinux: security: Move selinux_state to a
 separate page
In-Reply-To: <CANiq72=y7gapKpVKFwu30jDpv4qswgo5K3+u5QMOY4dtacKX=Q@mail.gmail.com>
References: <1610099389-28329-1-git-send-email-pnagar@codeaurora.org>
 <CANiq72=y7gapKpVKFwu30jDpv4qswgo5K3+u5QMOY4dtacKX=Q@mail.gmail.com>
Message-ID: <afa0b8674f87c3cac17bf725c826d37e@codeaurora.org>
X-Sender: pnagar@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 2021-01-08 20:55, Miguel Ojeda wrote:
> On Fri, Jan 8, 2021 at 10:52 AM Preeti Nagar <pnagar@codeaurora.org> 
> wrote:
>> 
>> We want to seek your suggestions and comments on the idea and the 
>> changes
>> in the patch.
> 
> Not sure why I was Cc'd, but I have a quick comment nevertheless.
> 
>> +#ifdef CONFIG_SECURITY_RTIC
>> +struct selinux_state selinux_state __rticdata;
>> +#else
>>  struct selinux_state selinux_state;
>> +#endif
> 
> If you define an empty __rticdata for the !CONFIG case, then we don't
> need #ifdefs for uses like this.
> 
> Cheers,
> Miguel
Thank you for the review! Will update this change in the next version of 
the patch soon.

Thanks,
Preeti
