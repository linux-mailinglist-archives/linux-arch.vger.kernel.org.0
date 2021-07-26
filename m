Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 652713D5B8D
	for <lists+linux-arch@lfdr.de>; Mon, 26 Jul 2021 16:27:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233843AbhGZNrL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 26 Jul 2021 09:47:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:47300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233657AbhGZNrL (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 26 Jul 2021 09:47:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7401E60F37;
        Mon, 26 Jul 2021 14:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627309660;
        bh=Hny3S4bK8lPLJq0Ngo4+VpBfahxBW1AWq54BVJylhv0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Dujh/cNBaldi8s6+idkZZoUGvjLI9S7O619ejgOTnjTxNf6z+g2pKyly9iZ/EHPuB
         LHLUCMkPj/5igWle3VWmSJa9aSOlXa+cIKHmH/AhJX3+Z6e1dUOIaypOW4ALhfAFL/
         t2+vqlybWCGGBzltmZWLoYZ6bGCFld39F0GdprjGGS8azpTmGAd/9If3zEe6ne7HWL
         Wa4mphphZoGxbI4ais/ssFOhTf4+bbccZ+B/bQZT6LKtE1MBwENnbmUkBCmjJYtbsp
         jALr3DBZcZwBr49ssjzIbzoWLKh+1aKaL9m8tbhnkSRHehF1YgWd1/QbRVNOl2G9Wx
         cZjK+ApCFOn6Q==
Subject: Re: [PATCH v4 3/3] m68k: track syscalls being traced with shallow
 user context stack
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Michael Schmitz <schmitzmic@gmail.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andreas Schwab <schwab@linux-m68k.org>
References: <1624407696-20180-1-git-send-email-schmitzmic@gmail.com>
 <1624407696-20180-4-git-send-email-schmitzmic@gmail.com>
 <CAMuHMdVA5d7z6awGrpJ+Tb3PRxz7Nczd_SLXZ=cAwsS8tFU_vg@mail.gmail.com>
 <f99d3d82-150b-62fc-3b38-141710a4826e@gmail.com>
 <CAHk-=wgVFUJAD62jtpbbKddu1ZeGF+nR4VuTGzQjS_ncCa5nQQ@mail.gmail.com>
From:   Greg Ungerer <gerg@kernel.org>
Message-ID: <c7945741-ec10-afc0-065f-35dcdf5924ea@kernel.org>
Date:   Tue, 27 Jul 2021 00:27:35 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wgVFUJAD62jtpbbKddu1ZeGF+nR4VuTGzQjS_ncCa5nQQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


On 26/7/21 7:00 am, Linus Torvalds wrote:
> On Sun, Jul 25, 2021 at 1:48 PM Michael Schmitz <schmitzmic@gmail.com> wrote:
>>
>> Just out of interest - what would be the correct way to set/clear a
>> single bit on Coldfire? Add/subtract the 1<<bit value?
> 
> I think BSET/BCLR are the way to go.

Yep, they are available on all ColdFire revisions.
I think they are the best choice here.


> Or, alternatively, put the constant in a register, and use a longword
> memory access. The arithmetic ops don't do immediates _and_ memory
> operands in Coldfire, and they don't do byte ops.
> 
> Or something like that.

Yes, that is right with one exception. You can use addq with immediates
of value 1 to 8 with memory operands.

Regards
Greg

