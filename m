Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0508F220989
	for <lists+linux-arch@lfdr.de>; Wed, 15 Jul 2020 12:08:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728044AbgGOKIF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 15 Jul 2020 06:08:05 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:39274 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbgGOKIF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 15 Jul 2020 06:08:05 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4B6CkV4FBpz1rtyc;
        Wed, 15 Jul 2020 12:08:02 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4B6CkV314jz1qrDX;
        Wed, 15 Jul 2020 12:08:02 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id FGDnadHvMCHE; Wed, 15 Jul 2020 12:08:01 +0200 (CEST)
X-Auth-Info: SROASM7rfZT/tTfsxwe1kv5TsJm31oTs8VM99Ep5Tztmu2l+TlRAmnN9rOw31QxB
Received: from igel.home (ppp-46-244-186-2.dynamic.mnet-online.de [46.244.186.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Wed, 15 Jul 2020 12:08:01 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
        id 053902C226F; Wed, 15 Jul 2020 12:08:00 +0200 (CEST)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     linuxppc-dev@lists.ozlabs.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-arch@vger.kernel.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v2] powerpc: select ARCH_HAS_MEMBARRIER_SYNC_CORE
References: <20200715094829.252208-1-npiggin@gmail.com>
X-Yow:  I Know A Joke
Date:   Wed, 15 Jul 2020 12:08:00 +0200
In-Reply-To: <20200715094829.252208-1-npiggin@gmail.com> (Nicholas Piggin's
        message of "Wed, 15 Jul 2020 19:48:29 +1000")
Message-ID: <87zh816qgv.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.0.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Jul 15 2020, Nicholas Piggin wrote:

> diff --git a/arch/powerpc/include/asm/exception-64e.h b/arch/powerpc/include/asm/exception-64e.h
> index 54a98ef7d7fe..071d7ccb830f 100644
> --- a/arch/powerpc/include/asm/exception-64e.h
> +++ b/arch/powerpc/include/asm/exception-64e.h
> @@ -204,7 +204,11 @@ exc_##label##_book3e:
>  	LOAD_REG_ADDR(r3,interrupt_base_book3e);\
>  	ori	r3,r3,vector_offset@l;		\
>  	mtspr	SPRN_IVOR##vector_number,r3;
> -
> +/*
> + * powerpc relies on return from interrupt/syscall being context synchronising
> + * (which rfi is) to support ARCH_HAS_MEMBARRIER_SYNC_CORE without additional
> + * additional synchronisation instructions.

s/additonal//

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
