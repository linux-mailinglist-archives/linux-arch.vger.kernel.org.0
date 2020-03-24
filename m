Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AFAFE190436
	for <lists+linux-arch@lfdr.de>; Tue, 24 Mar 2020 05:14:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726069AbgCXEOC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 24 Mar 2020 00:14:02 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:58047 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725784AbgCXEOC (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 24 Mar 2020 00:14:02 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 78759cff;
        Tue, 24 Mar 2020 04:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=date:from:to
        :cc:subject:message-id:references:mime-version:content-type
        :in-reply-to; s=mail; bh=bRcFHSD3AZu6n0An49AgKL6gT/M=; b=d4sYSCG
        USolkQUAuN4TPEmQWRGkj5T3GOpX6R5XldJ/M1g+16DS2OPBcoKRJ5XJpkCuOwP2
        LoH1Pm9170PLZlrYzMwgOvCRyS+siIdtiTdBmcURrDILebbAXeTRdtNw1Ddf6/B+
        3AsHx/XMbo2tex8VV93g4Yiz5RlCcRhlk27ID2s/XnKPNoCaSgq7f+I9x38s/0vM
        P5rlntk1m3gvrfcL0ATBRvOw4ltLPTpEiX6GwRIAYTWXwBPM7de1im3Hr3n0Akkg
        JNeKgUTSf7CHI5HtVsPeefkZJIlKoIKkmFBIm941t7yZkfbdUGrT7LzGNLEXjy05
        VaUb3+VZBY/YAsg==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 9611e98d (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO);
        Tue, 24 Mar 2020 04:06:56 +0000 (UTC)
Date:   Mon, 23 Mar 2020 22:13:47 -0600
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     Christopher Lameter <cl@linux.com>,
        Dennis Zhou <dennis@kernel.org>,
        Ben Dooks <ben.dooks@codethink.co.uk>,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tejun Heo <tj@kernel.org>, Nicholas Piggin <npiggin@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] fix __percpu annotation in asm-generic
Message-ID: <20200324041347.GA186169@zx2c4.com>
References: <20191126200619.63348-1-luc.vanoostenryck@gmail.com>
 <alpine.DEB.2.21.1911271553560.16980@www.lameter.com>
 <20191127175350.GA52308@dennisz-mbp.dhcp.thefacebook.com>
 <20191127225432.ttwxm3hxtg5utfaz@ltop.local>
 <alpine.DEB.2.21.1911291808530.1365@www.lameter.com>
 <20191130000037.zsendu5pk7p75xqf@ltop.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191130000037.zsendu5pk7p75xqf@ltop.local>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Nov 30, 2019 at 01:00:37AM +0100, Luc Van Oostenryck wrote:
> Note: it would be much much nicer to do all these type generic
>       macros with '__auto_type' (only supported in GCC 4.9 IIUC
>       and supported in sparse but it shouldn't be very hard to do)..

I'm curious to know if you know why we're not using __auto_type. Because
we're stuck on gcc 4.6, or is there a more subtle reason?

Jason
