Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3F5032F2FF
	for <lists+linux-arch@lfdr.de>; Fri,  5 Mar 2021 19:43:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbhCESm6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 5 Mar 2021 13:42:58 -0500
Received: from gate.crashing.org ([63.228.1.57]:49841 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229716AbhCESmr (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 5 Mar 2021 13:42:47 -0500
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 125IZHLo027274;
        Fri, 5 Mar 2021 12:35:17 -0600
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 125IZGLm027273;
        Fri, 5 Mar 2021 12:35:16 -0600
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Fri, 5 Mar 2021 12:35:16 -0600
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Will Deacon <will@kernel.org>, linux-arch@vger.kernel.org,
        robh@kernel.org, daniel@gimpelevich.san-francisco.ca.us,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org, danielwa@cisco.com
Subject: Re: [PATCH v2 1/7] cmdline: Add generic function to build command line.
Message-ID: <20210305183516.GY29191@gate.crashing.org>
References: <cover.1614705851.git.christophe.leroy@csgroup.eu> <d8cf7979ad986de45301b39a757c268d9df19f35.1614705851.git.christophe.leroy@csgroup.eu> <20210303172810.GA19713@willie-the-truck> <a0cfef11-efba-2e5c-6f58-ed63a2c3bfa0@csgroup.eu> <20210303174627.GC19713@willie-the-truck> <dc6576ac-44ff-7db4-d718-7565b83f50b8@csgroup.eu> <20210303181651.GE19713@willie-the-truck> <87sg59rewl.fsf@mpe.ellerman.id.au> <11d7af27-28cb-0eed-0f33-6669cbf7f1bb@csgroup.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <11d7af27-28cb-0eed-0f33-6669cbf7f1bb@csgroup.eu>
User-Agent: Mutt/1.4.2.3i
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Mar 05, 2021 at 01:49:03PM +0100, Christophe Leroy wrote:
> Le 05/03/2021 à 12:58, Michael Ellerman a écrit :
> >prom_init runs as an OF client, with the MMU off (except on some Apple
> >machines), and we don't own the MMU. So there's really nothing we can do :)
> >
> >Though now that I look at it, I don't think we should be doing this
> >level of commandline handling in prom_init. It should just grab the
> >value from firmware and pass it to the kernel proper, and then all the
> >prepend/append/force etc. logic should happen there.
> 
> But then, how do you handle the command line parameters that are needed by 
> prom_init ?
> 
> For instance, prom_init_mem() use 'prom_memory_limit', which comes from the 
> "mem=" option in the command line.

*Reading* it is easy, much easier than modifying it.


Segher
