Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6042367F6F
	for <lists+linux-arch@lfdr.de>; Thu, 22 Apr 2021 13:19:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235800AbhDVLSk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 22 Apr 2021 07:18:40 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:33763 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbhDVLSj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 22 Apr 2021 07:18:39 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4FQvzY1bPhz1qtQ1;
        Thu, 22 Apr 2021 13:18:01 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4FQvzY04ZPz1sP6V;
        Thu, 22 Apr 2021 13:18:00 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id 7qq233JVG0A0; Thu, 22 Apr 2021 13:18:00 +0200 (CEST)
X-Auth-Info: SDCESNpM6nnl9vBv/fRrOUlX2mB/X37cwnl6ojaX9iviaRZ/aApKWEry9kWSiW5L
Received: from igel.home (ppp-46-244-186-149.dynamic.mnet-online.de [46.244.186.149])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Thu, 22 Apr 2021 13:18:00 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
        id 66AD42C368F; Thu, 22 Apr 2021 13:17:59 +0200 (CEST)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Huacai Chen <chenhuacai@kernel.org>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-arch@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] MIPS: Avoid DIVU in `__div64_32' is result would be
 zero
References: <alpine.DEB.2.21.2104200044060.44318@angie.orcam.me.uk>
        <alpine.DEB.2.21.2104200331110.44318@angie.orcam.me.uk>
X-Yow:  UH-OH!!  I put on ``GREAT HEAD-ON TRAIN COLLISIONS of the 50's''
 by mistake!!!
Date:   Thu, 22 Apr 2021 13:17:59 +0200
In-Reply-To: <alpine.DEB.2.21.2104200331110.44318@angie.orcam.me.uk> (Maciej
        W. Rozycki's message of "Tue, 20 Apr 2021 04:50:48 +0200 (CEST)")
Message-ID: <87czumin4o.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Subject typo: s/is/if/

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
