Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 001153D6896
	for <lists+linux-arch@lfdr.de>; Mon, 26 Jul 2021 23:25:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231250AbhGZUox (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 26 Jul 2021 16:44:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230235AbhGZUox (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 26 Jul 2021 16:44:53 -0400
Received: from mail-out.m-online.net (mail-out.m-online.net [IPv6:2001:a60:0:28:0:1:25:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F350C061757
        for <linux-arch@vger.kernel.org>; Mon, 26 Jul 2021 14:25:21 -0700 (PDT)
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4GYXyQ4PWMz1s9Mk;
        Mon, 26 Jul 2021 23:25:18 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4GYXyQ360Mz1qrx7;
        Mon, 26 Jul 2021 23:25:18 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id ORS6_E4pAZpo; Mon, 26 Jul 2021 23:25:17 +0200 (CEST)
X-Auth-Info: bt9SpAPZSXKmc/Df0lqQWngVGpecbke5Io7yK3vnUyPmzvu9mSI8stysQH1k6lUS
Received: from igel.home (ppp-46-244-163-183.dynamic.mnet-online.de [46.244.163.183])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Mon, 26 Jul 2021 23:25:17 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
        id 2AA562C2604; Mon, 26 Jul 2021 23:25:17 +0200 (CEST)
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
        <87a6m8kgtx.fsf_-_@disp2133> <875yww7s01.fsf@igel.home>
        <87k0lcizu7.fsf@disp2133>
X-Yow:  Can you MAIL a BEAN CAKE?
Date:   Mon, 26 Jul 2021 23:25:17 +0200
In-Reply-To: <87k0lcizu7.fsf@disp2133> (Eric W. Biederman's message of "Mon,
        26 Jul 2021 15:29:04 -0500")
Message-ID: <871r7k7ooy.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Jul 26 2021, Eric W. Biederman wrote:

> I could not find a reference mentioning jbra.  Do I need to look in the
> gas source or do you know if there is a better source?

It's a pseudo insn that is relaxed to the optimal branch insn.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
