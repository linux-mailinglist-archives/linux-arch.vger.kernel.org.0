Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB29620FCD9
	for <lists+linux-arch@lfdr.de>; Tue, 30 Jun 2020 21:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728220AbgF3Tk0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 30 Jun 2020 15:40:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727104AbgF3Tk0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 30 Jun 2020 15:40:26 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0905CC061755;
        Tue, 30 Jun 2020 12:40:25 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jqM72-002x8g-D9; Tue, 30 Jun 2020 19:40:12 +0000
Date:   Tue, 30 Jun 2020 20:40:12 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Tony Luck <tony.luck@intel.com>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH 18/41] regset: new method and helpers for it
Message-ID: <20200630194012.GH2786714@ZenIV.linux.org.uk>
References: <20200629182349.GA2786714@ZenIV.linux.org.uk>
 <20200629182628.529995-1-viro@ZenIV.linux.org.uk>
 <20200629182628.529995-18-viro@ZenIV.linux.org.uk>
 <CAHk-=wjd5HML-EuPGH7J8CjWJrbnMhst3NJbcUyt-P0RV649nA@mail.gmail.com>
 <20200629203028.GB2786714@ZenIV.linux.org.uk>
 <20200630132508.GF2786714@ZenIV.linux.org.uk>
 <CAHk-=whAuAEXw1s2jF01nmT7iPWEeRv+ggKgCJ1U96-6KGgCmg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whAuAEXw1s2jF01nmT7iPWEeRv+ggKgCJ1U96-6KGgCmg@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jun 30, 2020 at 09:53:12AM -0700, Linus Torvalds wrote:
> On Tue, Jun 30, 2020 at 6:25 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > How about ->regset_get()?
> 
> Sounds good to me. And if you ever do something similar for 'set', you
> have a natural name to pick.

Umm...  Something similar for 'set' would, AFAICS, work reasonably well
with the following primitives.
membuf_read(&from, data, size) -- copy min(size, amount left)
membuf_fetch(&from, data) -- copy min(sizeof(data), amount left) into data
			(obviously a macro)
membuf_skip(&from, size) -- obvious
membuf_pick(&from, size), along the lines of
	if (unlikely(size > p->left)
		return ERR_PTR(-EINVAL);
	res = p->p;
	p->p += size;
	p->left -= size;
	return res;

So it would be something like

int regset_tls_set(struct task_struct *target, const struct user_regset *regset,
                   struct membuf from)
{
        const struct user_desc *info;
	int n = from.left / sizeof(*info);
        int i;

	info = membuf_pick(&from, n * sizeof(*info)); // can't fail here
        for (i = 0; i < n; i++)
                if (!tls_desc_okay(info + i))
                        return -EINVAL;

        set_tls_desc(target, GDT_ENTRY_TLS_MIN, info, n);
        return 0;
}

and

static int genregs32_set(struct task_struct *target,
                         const struct user_regset *regset,
                         struct membuf from)
{
	int err;
	unsigned pos, v;

	for (pos = 0; from.left; pos += sizeof(u32)) {
		membuf_fetch(&from, v);
		err = putreg32(target, pos, v);
		if (err)
			return err;
	}
	return 0;
}

or

/*
 * Copy the supplied 64-bit NT_MIPS_DSP buffer to the DSP context.
 */
static int dsp64_set(struct task_struct *target,
                     const struct user_regset *regset,
                     struct membuf from)
{
        if (!cpu_has_dsp)
                return -EIO;

	membuf_read(&from, target->thread.dsp.dspr, NUM_DSP_REGS * sizeof(u64));
	return membuf_read(&from, target->thread.dsp.dspcontrol, sizeof(u64));
}

etc.
