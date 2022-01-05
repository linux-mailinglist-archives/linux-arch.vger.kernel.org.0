Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5461E485202
	for <lists+linux-arch@lfdr.de>; Wed,  5 Jan 2022 12:51:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239794AbiAELvX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 5 Jan 2022 06:51:23 -0500
Received: from mengyan1223.wang ([89.208.246.23]:37506 "EHLO mengyan1223.wang"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239785AbiAELvX (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 5 Jan 2022 06:51:23 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
        (Client did not present a certificate)
        (Authenticated sender: xry111@mengyan1223.wang)
        by mengyan1223.wang (Postfix) with ESMTPSA id 64BB76591B;
        Wed,  5 Jan 2022 06:51:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mengyan1223.wang;
        s=mail; t=1641383479;
        bh=Fn7zHOmdeG4QcUKhnX1J7PW2F5GNpl1BqvGNa7CyV7c=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=1ho3+7RhzEeOwU8RUFJlu2+cV483V+bfN7wsB/Cjd85KcaEr+7wlaspHDFcmUrEG0
         SQf7urJlf7pp5qXRbl7HgdCeRpRnXtEZ09Qz//8dOu0svR2XRIFN+w4v+ucPfHUnFH
         jUWiZf5DT3923i9WhRmGjRybvb3saO+iogZBJHaw+RKnJl0ECtvTexicaKMcpDk0C4
         B+PFPa+Pcc4vR6pG1qXmfoQfNcI/fVK0+6FOdbWbf2FCoQH0Zh2L3Rwsrc5PBrmMBA
         Y8y3vdyhLz+Ima2D5Qc+jD99qAmb8Hod7XakpSUnZJ6T/wmGo3mrHlRMJiC+krAS+x
         JZgqSW1XxjDIg==
Message-ID: <6d0169ca8c9e417308d3b9f96cd0ef446ee36fe7.camel@mengyan1223.wang>
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
Date:   Wed, 05 Jan 2022 19:51:14 +0800
In-Reply-To: <CAAhV-H6R=xWL18AH7HzeXHOVD_d-5m7RvdQCLkOR1NeDZ_0HMw@mail.gmail.com>
References: <20211013063656.3084555-1-chenhuacai@loongson.cn>
         <722477bcc461238f96c3b038b2e3379ee49efdac.camel@mengyan1223.wang>
         <CAAhV-H40oWqkD+tQ3=XA8ijQGukkeG5O1M1JL3v5i402dFLK+Q@mail.gmail.com>
         <587ab54d77af2fb4cdbe0530cdd5e550c3e968db.camel@mengyan1223.wang>
         <CAAhV-H6R=xWL18AH7HzeXHOVD_d-5m7RvdQCLkOR1NeDZ_0HMw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, 2022-01-05 at 17:40 +0800, Huacai Chen wrote:
> Hi, Ruoyao,
> 
> The problem still exists in 5.16-rc8, can you try to change
> cpu_relax() definition to smp_mb()? It seems can fix the problem.

Is there any workload which can triggers the panic?  I can't trigger it
by building and testing GCC, or building the kernel anymore.

And is your "stable" issue the same one I'd encountered?  To me changing
barrier() to smp_mb() may fix some deadlock, but not a panic.  (I'm not
an expert on CPU architecture or kernel programming, so maybe I'm wrong
here.)

I'll put my 3A5000 machine into a loop building kernel and see if I can
trigger the panic again...
-- 
Xi Ruoyao <xry111@mengyan1223.wang>
School of Aerospace Science and Technology, Xidian University
