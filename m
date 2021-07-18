Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B61253CC8A3
	for <lists+linux-arch@lfdr.de>; Sun, 18 Jul 2021 12:53:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232312AbhGRK4B (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 18 Jul 2021 06:56:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230461AbhGRK4B (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 18 Jul 2021 06:56:01 -0400
X-Greylist: delayed 323 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 18 Jul 2021 03:53:03 PDT
Received: from mail-out.m-online.net (mail-out.m-online.net [IPv6:2001:a60:0:28:0:1:25:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F1FAC061762
        for <linux-arch@vger.kernel.org>; Sun, 18 Jul 2021 03:53:03 -0700 (PDT)
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4GSMBJ4sf1z1sFgy;
        Sun, 18 Jul 2021 12:47:36 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4GSMBJ44gsz1qql3;
        Sun, 18 Jul 2021 12:47:36 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id gbkxjiTbs38y; Sun, 18 Jul 2021 12:47:35 +0200 (CEST)
X-Auth-Info: XlHQaEktah6fBHjo3oGy6WDaqd34t0/uzqM+ADOwTmL48xrF5wxgGVNxj0awtjxF
Received: from igel.home (ppp-46-244-172-145.dynamic.mnet-online.de [46.244.172.145])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Sun, 18 Jul 2021 12:47:35 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
        id 2CCA52C251F; Sun, 18 Jul 2021 12:47:32 +0200 (CEST)
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
X-Yow:  GOOD-NIGHT, everybody..  Now I have to go administer FIRST-AID
 to my pet LEISURE SUIT!!
Date:   Sun, 18 Jul 2021 12:47:32 +0200
In-Reply-To: <af434994-5c61-0e3a-c7bc-3ed966ccb44f@gmail.com> (Michael
        Schmitz's message of "Sun, 18 Jul 2021 11:04:31 +1200")
Message-ID: <87a6mj99vf.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Jul 18 2021, Michael Schmitz wrote:

> +	addql   #8,%sp
> +	addql   #8,%sp
> +	addql   #8,%sp
> +	addql   #8,%sp
> +	addql   #8,%sp
> +	addql   #4,%sp

aka     lea     44(%sp),%sp

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
