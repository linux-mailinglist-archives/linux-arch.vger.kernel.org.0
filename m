Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C62B4F484B
	for <lists+linux-arch@lfdr.de>; Wed,  6 Apr 2022 02:01:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbiDEVe3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 5 Apr 2022 17:34:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444551AbiDEPlj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 5 Apr 2022 11:41:39 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03466F8EE5;
        Tue,  5 Apr 2022 07:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jJ72nyQjgyMortAHdvw06/vFEylkSYuiFVuOxXrhPF4=; b=SwqA6RhnQVGyo1EdkB/Yf6mm02
        Dl5JtcMTBnIo1saXpfrgbyE/JGZcRsHcp3NLkoWMe5//d3yTDV4wxHJK11pA2rmaZH3TltzAh7fBb
        XY5ctXudO1Aje6BGJCcBm0qhxr3+SocKS+h5rCtfnw9q15J3zakCAN4hvr/ZpcGT4+AjO9QioIGNn
        bpzyDFsBioroiBC3Em3r/UCGE5vRMoyK7fZe1MLCHbskQpxFP76afxNXjSE7JhFtksghvu4si2d1s
        2how848sOs3fzXvTv6gxg+WmiLi8GH1y62pqjHtm/M3icwJ0jG8PmR6ZytAPKMB37cSF4HklVQ14q
        zM5YH+Mw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nbjoD-001sCl-Ae; Tue, 05 Apr 2022 14:05:26 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BD2953001EA;
        Tue,  5 Apr 2022 16:05:22 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9951B2DC78FE1; Tue,  5 Apr 2022 16:05:22 +0200 (CEST)
Date:   Tue, 5 Apr 2022 16:05:22 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, gcc@gcc.gnu.org,
        catalin.marinas@arm.com, will@kernel.org, marcan@marcan.st,
        maz@kernel.org, szabolcs.nagy@arm.com, f.fainelli@gmail.com,
        opendmb@gmail.com, Andrew Pinski <pinskia@gmail.com>,
        Ard Biesheuvel <ardb@kernel.org>, x86@kernel.org,
        andrew.cooper3@citrix.com, Jeremy Linton <jeremy.linton@arm.com>
Subject: Re: GCC 12 miscompilation of volatile asm (was: Re: [PATCH]
 arm64/io: Remind compiler that there is a memory side effect)
Message-ID: <YkxMov3qpHxFa/n3@hirez.programming.kicks-ass.net>
References: <20220401164406.61583-1-jeremy.linton@arm.com>
 <Ykc0xrLv391/jdJj@FVFF77S0Q05N>
 <Ykw7UnlTnx63z/Ca@FVFF77S0Q05N>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ykw7UnlTnx63z/Ca@FVFF77S0Q05N>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Apr 05, 2022 at 01:51:30PM +0100, Mark Rutland wrote:
> Hi all,
> 
> [adding kernel folk who work on asm stuff]
> 
> As a heads-up, GCC 12 (not yet released) appears to erroneously optimize away
> calls to functions with volatile asm. Szabolcs has raised an issue on the GCC
> bugzilla:  
> 
>   https://gcc.gnu.org/bugzilla/show_bug.cgi?id=105160
> 
> ... which is a P1 release blocker, and is currently being investigated.
> 
> Jemery originally reported this as an issue with {readl,writel}_relaxed(), but
> the underlying problem doesn't have anything to do with those specifically.
> 
> I'm dumping a bunch of info here largely for posterity / archival, and to find
> out who (from the kernel side) is willing and able to test proposed compiler
> fixes, once those are available.
> 
> I'm happy to do so for aarch64; Peter, I assume you'd be happy to look at the
> x86 side?

Sure..
