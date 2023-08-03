Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4417A76EA03
	for <lists+linux-arch@lfdr.de>; Thu,  3 Aug 2023 15:23:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235867AbjHCNXv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 3 Aug 2023 09:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235423AbjHCNXm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 3 Aug 2023 09:23:42 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6E012D73;
        Thu,  3 Aug 2023 06:23:33 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 5F80631A;
        Thu,  3 Aug 2023 13:23:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 5F80631A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1691069012; bh=jytHCpUw2jZly6z8bKslDHd4gKAoe940LLj8wuptKX0=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=mXrZ+EpT71XXOvKG72rCmQJ7UIr5/pFrV2KJwUFDaGKPt41Iy3JwRqpHydRiFF0z6
         dnpa2I0i+GMsRCQgwi1UkfQ6PYG7X4EYcagD91jVsSHlnX8d5Fr4hagXplMSAuLooC
         5ATExfWIY1MbSOqFsmLoY+cDpKS9QfzL3VSueA+hOsM9ulFIWTdB59dRNwmAggt4Dl
         EdP2mCdy/qFVilrbwuTvki0/tUHDvEGozWHQLXpeHpKAEFHAc/tSf9tF1QXC43cPeS
         PUJJ9ogkRL4lrCpRPoau2HY4Sgeo0sC5EDMuccRgzMbFUask/g1uUc88oaPcZO59HB
         I36/kP5NzDY8Q==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Wei Liu <wei.liu@kernel.org>,
        Nuno Das Neves <nunodasneves@linux.microsoft.com>
Cc:     linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arch@vger.kernel.org, mikelley@microsoft.com,
        kys@microsoft.com, wei.liu@kernel.org, haiyangz@microsoft.com,
        decui@microsoft.com, ssengar@linux.microsoft.com,
        mukeshrathor@microsoft.com, stanislav.kinsburskiy@gmail.com,
        jinankjain@linux.microsoft.com, apais@linux.microsoft.com,
        Tianyu.Lan@microsoft.com, vkuznets@redhat.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, will@kernel.org, catalin.marinas@arm.com
Subject: Re: [PATCH 12/15] Documentation: Reserve ioctl number for mshv driver
In-Reply-To: <ZMrzgeETgsn1iTfe@liuwe-devbox-debian-v2>
References: <1690487690-2428-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1690487690-2428-13-git-send-email-nunodasneves@linux.microsoft.com>
 <ZMrzgeETgsn1iTfe@liuwe-devbox-debian-v2>
Date:   Thu, 03 Aug 2023 07:23:31 -0600
Message-ID: <878ras8dkc.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Wei Liu <wei.liu@kernel.org> writes:

> This needs an ack from Jonathan.

From me?  If every docs change needed an ack from me we'd be in rather
worse shape than we are now.  You can certainly have one:

Acked-by: Jonathan Corbet <corbet@lwn.net>

...but I don't control ioctl() numbers and don't need to gate-keep a
change like this.

Thanks,

jon

> On Thu, Jul 27, 2023 at 12:54:47PM -0700, Nuno Das Neves wrote:
>> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
>> ---
>>  Documentation/userspace-api/ioctl/ioctl-number.rst | 2 ++
>>  1 file changed, 2 insertions(+)
>> 
>> diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst b/Documentation/userspace-api/ioctl/ioctl-number.rst
>> index 0a1882e296ae..ca6b82419118 100644
>> --- a/Documentation/userspace-api/ioctl/ioctl-number.rst
>> +++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
>> @@ -355,6 +355,8 @@ Code  Seq#    Include File                                           Comments
>>  0xB6  all    linux/fpga-dfl.h
>>  0xB7  all    uapi/linux/remoteproc_cdev.h                            <mailto:linux-remoteproc@vger.kernel.org>
>>  0xB7  all    uapi/linux/nsfs.h                                       <mailto:Andrei Vagin <avagin@openvz.org>>
>> +0xB8  all    uapi/linux/mshv.h                                       Microsoft Hypervisor VM management APIs
>> +                                                                     <mailto:linux-hyperv@vger.kernel.org>
>>  0xC0  00-0F  linux/usb/iowarrior.h
>>  0xCA  00-0F  uapi/misc/cxl.h
>>  0xCA  10-2F  uapi/misc/ocxl.h
>> -- 
>> 2.25.1
>> 
