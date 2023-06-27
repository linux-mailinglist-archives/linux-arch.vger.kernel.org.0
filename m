Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C57273FBAB
	for <lists+linux-arch@lfdr.de>; Tue, 27 Jun 2023 14:05:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231713AbjF0MFf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 27 Jun 2023 08:05:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjF0MFd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 27 Jun 2023 08:05:33 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E8E41A2;
        Tue, 27 Jun 2023 05:05:32 -0700 (PDT)
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9888E1EC069A;
        Tue, 27 Jun 2023 14:05:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1687867530;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=GxpWEkp2YtwsKbgrIeKECyl8PncOwwMXHndCVDighMw=;
        b=U8Gn7Fg+0VWB5vAtvK5OdZ4NflNcU5m5g2YdWCD1uQasjbF+unzPTkAzxLQRyuNwUkI0QK
        fdst5UYbWYQIyIXlXcIEis0JkA5kcepz6dr6XmT/M/dQNfiVQu5Vs2RiSeFp03JaFQg/W9
        YbW7JjwH/DANglUGpEA0i4UGHQDj4vY=
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id VSbxOFp3a_Dg; Tue, 27 Jun 2023 12:05:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1687867527; bh=GxpWEkp2YtwsKbgrIeKECyl8PncOwwMXHndCVDighMw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fy6n217BvE4EsBuujdU16jKoz8ZgDNMPHlbQ0fFVIMjbNSKLoiV1LGKh1CTdzgUFG
         qCTaR3dYbkcBIs5DVl9537rbIos7ZxeeV1CyDWbnr6pZXE/JC52/swy57cK/NHFCJW
         PKPcM8Z5cLD2PR5QQ/HETt6/VLgY4glVdP6rkYQzqEttsVMmEfHkiVXePsZwEmEkCV
         Y4TR7Y/EYO1SpC9mDVodMLp8AVHx0sdwnQj5s53IHq7ki+sQktQjneHwTWpvV2yiKd
         9m658EItUPms9uIYNK7D2tUxdlzmLH2ifGxYWYHgJO7wkb36qgUDLioFHU1BbhKBIK
         AGg1y+Xf7sR6MuShgj8NYu/Uuea4XdjS5EGlhgwKHxML1Sbtuz6unJ17Hl2VAXgmbw
         zC6hSrMVz/2TvommXGjfKqVpjokoAjfTEmLlR1hr6HP7jGgrY7kxylxhuOStYhV+Hb
         YBFp6oUzp8LKUnwL7dDgzybKH3T7bzT2YI/K4ABPRYzYPWMAj4eXXLkh8uF8JN17Ff
         k21Te3/Yr1QDqDXqOCHdeQ43NJTpsmGMWBEmFDaU8nq7g5RduhhaheAaD8lH7Mzn9+
         H0EoUya+XPEk5O1xzvwC5HvgzDdBhEX5Bs/sdq0QyMAe7h0G2ObAzwUGwH6jfCLEgz
         R0KW4ujg9MTPhzkPXmYsW8ng=
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2FF2D40E0033;
        Tue, 27 Jun 2023 12:05:08 +0000 (UTC)
Date:   Tue, 27 Jun 2023 14:05:02 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Tianyu Lan <ltykernel@gmail.com>, kys@microsoft.com,
        haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
        tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, daniel.lezcano@linaro.org,
        arnd@arndb.de, michael.h.kelley@microsoft.com,
        Tianyu Lan <tiala@microsoft.com>, linux-arch@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkuznets@redhat.com
Subject: Re: [EXTERNAL] Re: [PATCH 5/9] x86/hyperv: Use vmmcall to implement
 Hyper-V hypercall in sev-snp enlightened guest
Message-ID: <20230627120502.GFZJrQbgSgOhj/44pW@fat_crate.local>
References: <20230601151624.1757616-1-ltykernel@gmail.com>
 <20230601151624.1757616-6-ltykernel@gmail.com>
 <20230608132127.GK998233@hirez.programming.kicks-ass.net>
 <8b93aa93-903f-3a69-77f9-0c6b694d826b@gmail.com>
 <d06bb33e-047f-c849-de6a-246bc361c7af@gmail.com>
 <20230627115002.GW83892@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230627115002.GW83892@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jun 27, 2023 at 01:50:02PM +0200, Peter Zijlstra wrote:
> On Tue, Jun 27, 2023 at 06:57:28PM +0800, Tianyu Lan wrote:
> 
> > > "There is no x86 SEV SNP feature(X86_FEATURE_SEV_SNP) flag
> 
> I'm sure we can arrange such a feature if we need it, this isn't rocket
> science. Boris?

https://lore.kernel.org/r/20230612042559.375660-7-michael.roth@amd.com

> This seems to work; it's a bit magical for having a nested ALTERNATIVE
> but the output seems correct (the outer alternative comes last in
> .altinstructions and thus has precedence). Sure the [thunk_target] input
> goes unsed in one of the alteratives, but who cares.

I'd like to avoid the nested alternative if not really necessary. I.e.,
a static_call should work here too no?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
