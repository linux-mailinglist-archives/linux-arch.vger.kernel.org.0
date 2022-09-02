Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DA7F5AAC86
	for <lists+linux-arch@lfdr.de>; Fri,  2 Sep 2022 12:35:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234723AbiIBKfT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 2 Sep 2022 06:35:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235967AbiIBKfL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 2 Sep 2022 06:35:11 -0400
Received: from forward503o.mail.yandex.net (forward503o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::613])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 816761011
        for <linux-arch@vger.kernel.org>; Fri,  2 Sep 2022 03:35:01 -0700 (PDT)
Received: from vla3-178a3f795968.qloud-c.yandex.net (vla3-178a3f795968.qloud-c.yandex.net [IPv6:2a02:6b8:c15:2584:0:640:178a:3f79])
        by forward503o.mail.yandex.net (Yandex) with ESMTP id 539D05C5063;
        Fri,  2 Sep 2022 13:34:54 +0300 (MSK)
Received: by vla3-178a3f795968.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id R3jjqKDmTO-Yqhm5HCq;
        Fri, 02 Sep 2022 13:34:53 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syntacore.com; s=mail; t=1662114893;
        bh=qstGMBMTzvZwX/PqmECUTBaQ2hySlR22czcR+Yy1yD0=;
        h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
        b=P9JweG7SRxrxYisCNSs26Djtr6O9lGebA6gSa63eGkruaq5XTSTQEVY7iYX/BWA/4
         8sqv0NTQok5gAfNwmgKjaMk07WVfYcdNoslFZrC7OKUEXhaSaB03PLuoriSmGajanl
         WihwdAEgIQovEQCvm8/h4Yf4Lih6NH5vNoELKFbU=
Authentication-Results: vla3-178a3f795968.qloud-c.yandex.net; dkim=pass header.i=@syntacore.com
Message-ID: <f5850a14-24c1-1619-b7b8-36663c216e32@syntacore.com>
Date:   Fri, 2 Sep 2022 13:34:51 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH v2] riscv: Fix permissions for all mm's during mm init
Content-Language: ru-RU, en-US
To:     Andrew Jones <ajones@ventanamicro.com>
Cc:     linux-arch@vger.kernel.org, linux-riscv@lists.infradead.org,
        Conor.Dooley@microchip.com, atishp@atishpatra.org,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, anup@brainfault.org
References: <20220830091612.513137-1-vladimir.isaev@syntacore.com>
 <20220901084740.v34npx77vlfclyje@kamzik>
From:   Vladimir Isaev <vladimir.isaev@syntacore.com>
In-Reply-To: <20220901084740.v34npx77vlfclyje@kamzik>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Andrew,

01.09.2022 11:47, Andrew Jones wrote:
> On Tue, Aug 30, 2022 at 12:16:12PM +0300, Vladimir Isaev wrote:
>> It is possible to have more than one mm (init_mm) during memory
>> permission fixes. In my case it was caused by request_module
>> from drivers/net/phy/phy_device.c and leads to following Oops
>> during free_initmem() on RV32 platform:

>> +void fix_kernel_mem_early(char *startp, char *endp, pgprot_t set_mask,
>> +			  pgprot_t clear_mask)
>> +{
>> +	struct task_struct *t, *s;
>> +
>> +	unsigned long start = (unsigned long)startp;
>> +	unsigned long end = PAGE_ALIGN((unsigned long)endp);
>> +
>> +	__set_memory_mm(current->active_mm, start, end, set_mask, clear_mask);
>> +	__set_memory_mm(&init_mm, start, end, set_mask, clear_mask);
>> +
> 
> Presumably this is only run at a point where it's safe not to take
> tasklist_lock. A comment explaining that would be helpful to readers
> and help avoid this code getting copy+pasted into points it's not
> safe.
> 

Thanks for your review. I sent v3 with added comment and
WARN_ON(system_state != SYSTEM_FREEING_INITMEM), because looks like we can do
such mm-s change in this state only (both free_initmem() and mark_rodata_ro()
are called in this state).

Thank you,
Vladimir Isaev
