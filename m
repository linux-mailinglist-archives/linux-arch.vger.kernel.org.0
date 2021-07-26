Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A34B93D67F4
	for <lists+linux-arch@lfdr.de>; Mon, 26 Jul 2021 22:13:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231857AbhGZTd1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 26 Jul 2021 15:33:27 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:42567 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231540AbhGZTd1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 26 Jul 2021 15:33:27 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4GYWN10cpsz1qxm3;
        Mon, 26 Jul 2021 22:13:53 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4GYWN06g4rz1qrxK;
        Mon, 26 Jul 2021 22:13:52 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id I5cRCfIFhPTv; Mon, 26 Jul 2021 22:13:52 +0200 (CEST)
X-Auth-Info: 3CfPstfoFvG9oxhsunU1+8tXeXfdDZ+PN3GoqbEWJN4L47buNOzrY7w5QAfJ/uZU
Received: from igel.home (ppp-46-244-163-183.dynamic.mnet-online.de [46.244.163.183])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Mon, 26 Jul 2021 22:13:51 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
        id E82262C265D; Mon, 26 Jul 2021 22:13:50 +0200 (CEST)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     ebiederm@xmission.com (Eric W. Biederman)
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        Brad Boyer <flar@allandria.com>, geert@linux-m68k.org,
        linux-arch@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        torvalds@linux-foundation.org
Subject: Re: [RFC][PATCH] signal/m68k: Use force_sigsegv(SIGSEGV) in
 fpsp040_die
References: <e9009e13-cfec-c494-0b3b-f334f75cd1e4@gmail.com>
        <af434994-5c61-0e3a-c7bc-3ed966ccb44f@gmail.com>
        <87h7gopvz2.fsf@disp2133>
        <328e59fb-3e8c-e4cd-06b4-1975ce98614a@gmail.com>
        <877dhio13t.fsf@disp2133>
        <12992a3c-0740-f90e-aa4e-1ec1d8ea38f6@gmail.com>
        <87tukkk6h3.fsf@disp2133>
        <df6618bf-d1bc-4759-2d14-934c22d54a83@gmail.com>
        <87eebn7w7y.fsf@igel.home>
        <db43bef1-7938-4fc1-853d-c20d66521329@gmail.com>
        <20210725101253.GA6096@allandria.com>
        <be3ddf9a-745e-4798-17a7-a9d0ddd7eef7@gmail.com>
        <87a6m8kgtx.fsf_-_@disp2133>
X-Yow:  Yes, Private DOBERMAN!!
Date:   Mon, 26 Jul 2021 22:13:50 +0200
In-Reply-To: <87a6m8kgtx.fsf_-_@disp2133> (Eric W. Biederman's message of
        "Mon, 26 Jul 2021 14:36:42 -0500")
Message-ID: <875yww7s01.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Jul 26 2021, Eric W. Biederman wrote:

> diff --git a/arch/m68k/fpsp040/skeleton.S b/arch/m68k/fpsp040/skeleton.S
> index a8f41615d94a..ec767523c012 100644
> --- a/arch/m68k/fpsp040/skeleton.S
> +++ b/arch/m68k/fpsp040/skeleton.S
> @@ -502,7 +502,8 @@ in_ea:
>  	.section .fixup,#alloc,#execinstr
>  	.even
>  1:
> -	jbra	fpsp040_die
> +	bsrl	fpsp040_die
> +	jmp	.Lnotkern

That should be jbra instead of jmp.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
