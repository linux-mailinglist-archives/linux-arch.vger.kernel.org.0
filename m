Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 721D648572A
	for <lists+linux-arch@lfdr.de>; Wed,  5 Jan 2022 18:21:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242191AbiAERVw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 5 Jan 2022 12:21:52 -0500
Received: from mengyan1223.wang ([89.208.246.23]:53730 "EHLO mengyan1223.wang"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230323AbiAERVw (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 5 Jan 2022 12:21:52 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
        (Client did not present a certificate)
        (Authenticated sender: xry111@mengyan1223.wang)
        by mengyan1223.wang (Postfix) with ESMTPSA id E325B65A9A;
        Wed,  5 Jan 2022 12:21:47 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mengyan1223.wang;
        s=mail; t=1641403311;
        bh=lQqSduRsA0o4a6IM8NvLfUF17x9jJ4pL2pbwCbpBxGk=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=CD8a5zlaG4oMTVKQcjfPEvVw3OAsjNPOenLOzpJp4z7vHcJxn5sgd6xK/Bo85swjr
         NpvPed3l/CMmy6sdRN/f8SJ9Cs6fGOu1CaSkiJxnzkoQSWRORevjPfwDu776xw3Rti
         T8YRP2GWWHJoHth74vppw0ZMD+p+CKfWp9qz0PLBc3vKzum3Xqxr6dgK1811DLSBSs
         VYTneXQhGWcwQyQo7mvD54eOyzq0NwOJsO21UQKc3PFAzl3c+ZbuYR6RJh210V0zfI
         yPfRrzzpfwdi4YDkGOwsNCmawJsbZ0vZW6czapW3ULBgJhXXJnjuVC+mt365heLm+y
         +K8EgwolkMWKg==
Message-ID: <211edcb700db30c4a6b37db87139e5fa47aeece0.camel@mengyan1223.wang>
Subject: Re: [PATCH V5 00/22] arch: Add basic LoongArch support
From:   Xi Ruoyao <xry111@mengyan1223.wang>
To:     Huacai Chen <chenhuacai@gmail.com>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Yanteng Si <siyanteng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Date:   Thu, 06 Jan 2022 01:21:46 +0800
In-Reply-To: <6d0169ca8c9e417308d3b9f96cd0ef446ee36fe7.camel@mengyan1223.wang>
References: <20211013063656.3084555-1-chenhuacai@loongson.cn>
         <722477bcc461238f96c3b038b2e3379ee49efdac.camel@mengyan1223.wang>
         <CAAhV-H40oWqkD+tQ3=XA8ijQGukkeG5O1M1JL3v5i402dFLK+Q@mail.gmail.com>
         <587ab54d77af2fb4cdbe0530cdd5e550c3e968db.camel@mengyan1223.wang>
         <CAAhV-H6R=xWL18AH7HzeXHOVD_d-5m7RvdQCLkOR1NeDZ_0HMw@mail.gmail.com>
         <6d0169ca8c9e417308d3b9f96cd0ef446ee36fe7.camel@mengyan1223.wang>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, 2022-01-05 at 19:51 +0800, Xi Ruoyao wrote:
> On Wed, 2022-01-05 at 17:40 +0800, Huacai Chen wrote:
> > Hi, Ruoyao,
> > 
> > The problem still exists in 5.16-rc8, can you try to change
> > cpu_relax() definition to smp_mb()? It seems can fix the problem.
> 
> Is there any workload which can triggers the panic?  I can't trigger it
> by building and testing GCC, or building the kernel anymore.
> 
> And is your "stable" issue the same one I'd encountered?  To me changing
> barrier() to smp_mb() may fix some deadlock, but not a panic.  (I'm not
> an expert on CPU architecture or kernel programming, so maybe I'm wrong
> here.)
> 
> I'll put my 3A5000 machine into a loop building kernel and see if I can
> trigger the panic again...

I can't reproduce the issue on 5.16-rc8.  But I can reproduce it on
5.16-rc5 and the s/barrier/smp_mb/ change fixes the issue.

I'm still puzzled: if there some workload which can reproduce the issue
more deterministic?
-- 
Xi Ruoyao <xry111@mengyan1223.wang>
School of Aerospace Science and Technology, Xidian University
