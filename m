Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AC92438687
	for <lists+linux-arch@lfdr.de>; Sun, 24 Oct 2021 06:24:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbhJXE0j (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 24 Oct 2021 00:26:39 -0400
Received: from angie.orcam.me.uk ([78.133.224.34]:34370 "EHLO
        angie.orcam.me.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbhJXE0i (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 24 Oct 2021 00:26:38 -0400
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 2A78B92009C; Sun, 24 Oct 2021 06:24:17 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 1C80092009B;
        Sun, 24 Oct 2021 06:24:17 +0200 (CEST)
Date:   Sun, 24 Oct 2021 06:24:17 +0200 (CEST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org
Subject: Re: [PATCH 05/20] signal/mips: Update (_save|_restore)_fp_context
 to fail with -EFAULT
In-Reply-To: <20211020174406.17889-5-ebiederm@xmission.com>
Message-ID: <alpine.DEB.2.21.2110240622100.45807@angie.orcam.me.uk>
References: <87y26nmwkb.fsf@disp2133> <20211020174406.17889-5-ebiederm@xmission.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, 20 Oct 2021, Eric W. Biederman wrote:

> When an instruction to save or restore a register from the stack fails
> in _save_fp_context or _restore_fp_context return with -EFAULT.  This
> change was made to r2300_fpu.S[1] but it looks like it got lost with
> the introduction of EX2[2].  This is also what the other implementation
> of _save_fp_context and _restore_fp_context in r4k_fpu.S does, and
> what is needed for the callers to be able to handle the error.

 Umm, right, good catch, thanks!  I think this ought to be backported.

Acked-by: Maciej W. Rozycki <macro@orcam.me.uk>

  Maciej
