Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E4F2366C70
	for <lists+linux-arch@lfdr.de>; Wed, 21 Apr 2021 15:18:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240208AbhDUNRV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 21 Apr 2021 09:17:21 -0400
Received: from angie.orcam.me.uk ([157.25.102.26]:39324 "EHLO
        angie.orcam.me.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241487AbhDUNMi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 21 Apr 2021 09:12:38 -0400
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id F36A49200BF; Wed, 21 Apr 2021 15:12:00 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id F05739200BC;
        Wed, 21 Apr 2021 15:12:00 +0200 (CEST)
Date:   Wed, 21 Apr 2021 15:12:00 +0200 (CEST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
cc:     Arnd Bergmann <arnd@arndb.de>, Huacai Chen <chenhuacai@kernel.org>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-arch@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] Reinstate and improve MIPS `do_div' implementation
In-Reply-To: <20210421120148.GC8637@alpha.franken.de>
Message-ID: <alpine.DEB.2.21.2104211507390.44318@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2104200044060.44318@angie.orcam.me.uk> <20210421120148.GC8637@alpha.franken.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, 21 Apr 2021, Thomas Bogendoerfer wrote:

> series applied to mips-next.

 Thanks!  I was about to send v2 with a small fix for an issue discovered 
with message formatting in the failure path of the test_div64 module, 
which was supposed to align the expected result with one actually produced 
for easier visual comparison.  Somehow I failed to realise that format 
specifiers will expand to text of a different length and therefore source 
string alignment won't do.

 I'll send an incremental change then.

  Maciej
