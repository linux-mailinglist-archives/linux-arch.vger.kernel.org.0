Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF12F3D4785
	for <lists+linux-arch@lfdr.de>; Sat, 24 Jul 2021 14:06:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231922AbhGXLZ3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 24 Jul 2021 07:25:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231709AbhGXLZ3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 24 Jul 2021 07:25:29 -0400
Received: from mail-out.m-online.net (mail-out.m-online.net [IPv6:2001:a60:0:28:0:1:25:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2977CC061757
        for <linux-arch@vger.kernel.org>; Sat, 24 Jul 2021 05:06:01 -0700 (PDT)
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4GX4dv1Wbmz1s8dB;
        Sat, 24 Jul 2021 14:05:55 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4GX4dv0mSsz1rmXb;
        Sat, 24 Jul 2021 14:05:55 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id 2xuYAc97Wpu0; Sat, 24 Jul 2021 14:05:54 +0200 (CEST)
X-Auth-Info: wO77jCK918RBVEMr6+v4ZlIa9eW1scqsY6nuBaDN4jL38SnGw0deMAm8W/mynhLG
Received: from igel.home (ppp-46-244-175-70.dynamic.mnet-online.de [46.244.175.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Sat, 24 Jul 2021 14:05:54 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
        id BBEE02C24BA; Sat, 24 Jul 2021 14:05:53 +0200 (CEST)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Michael Schmitz <schmitzmic@gmail.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>, geert@linux-m68k.org,
        linux-arch@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        torvalds@linux-foundation.org
Subject: Re: [PATCH v4 0/3] m68k: Improved switch stack handling
References: <1624407696-20180-1-git-send-email-schmitzmic@gmail.com>
        <87zgunzovm.fsf@disp2133>
        <3b4f287b-7be2-0e7b-ae5a-6c11972601fb@gmail.com>
        <1b656c02-925c-c4ba-03d3-f56075cdfac5@gmail.com>
        <8735scvklk.fsf@disp2133>
        <e9009e13-cfec-c494-0b3b-f334f75cd1e4@gmail.com>
        <af434994-5c61-0e3a-c7bc-3ed966ccb44f@gmail.com>
        <87h7gopvz2.fsf@disp2133>
        <328e59fb-3e8c-e4cd-06b4-1975ce98614a@gmail.com>
        <877dhio13t.fsf@disp2133>
        <12992a3c-0740-f90e-aa4e-1ec1d8ea38f6@gmail.com>
        <87tukkk6h3.fsf@disp2133>
        <df6618bf-d1bc-4759-2d14-934c22d54a83@gmail.com>
X-Yow:  YOW!!  I am having FUN!!
Date:   Sat, 24 Jul 2021 14:05:53 +0200
In-Reply-To: <df6618bf-d1bc-4759-2d14-934c22d54a83@gmail.com> (Michael
        Schmitz's message of "Sat, 24 Jul 2021 11:52:38 +1200")
Message-ID: <87eebn7w7y.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Jul 24 2021, Michael Schmitz wrote:

> According to my understanding, you can't get a F-line exception on
> 68040.

The F-line exeception vector is used for all FPU illegal and
unimplemented insns.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
