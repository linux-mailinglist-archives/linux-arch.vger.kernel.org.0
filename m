Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4BB8F1E4F
	for <lists+linux-arch@lfdr.de>; Wed,  6 Nov 2019 20:12:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731884AbfKFTL7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 6 Nov 2019 14:11:59 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38531 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732185AbfKFTL6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 6 Nov 2019 14:11:58 -0500
Received: by mail-wr1-f67.google.com with SMTP id j15so6715662wrw.5
        for <linux-arch@vger.kernel.org>; Wed, 06 Nov 2019 11:11:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EcgRR3fhItj7MngTpAkKZQgz86ETXxndudb9oWnZwxg=;
        b=rgRyO6x1nGDPENAhlTeX1XD1tL7bztL4f34POmMWurjqkhpHZRc6O0seKYBMbC9u2m
         GiOBZXsbYzd2cMwQ7Un5XYdpqxCR88JdJYcGqZ+EIZn0tz+O/gh+0gVymXtnTh3x3e+Q
         +vgQsiFQzsAF0f1SzF6rQeWosSl4KG7cSBO0cMeY/yFMtjaD3kOQUI7B0ybY2Mp1EYRj
         XlqQzSr4fPATOqhHF3AqAEPw28SBvkbGqiOwb13fJHc3e8IJB/HGyF85obDx5SBHYEOt
         r5PJ8CZ3wiWvJaTMjVlEH/zcloEiB3aDDbSMcFQnX/01veFTumtByBbnmVpbWkZ+fwuV
         UtjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EcgRR3fhItj7MngTpAkKZQgz86ETXxndudb9oWnZwxg=;
        b=qVp/suYi+wMfYCCDR9GU/LtHms2FMWbzmYGA5Ch3m13qqe7vTblmEVjcbQYa9IWsEl
         3FDvGYUP3yD+fA/Y6yOJs9kZ455uuazvLfR+nwuKtWyXWZOJl6fGiBodAAlxZyKKPRut
         nhTdGzJdaDIAU6JP4qSPwXqcsDdSFnyvS7wkZnHhSeQH/nD/BvzBOpb79bK50p56Xhwn
         S97lcpnSQB9mjeeYyF8Q0iSuWpwpCvWuq+rACDWdAkUHLzHFZ9vf/K3sX/arW5Puv9CL
         IfBJQmqqg09E+vrGTk1he9OEfxe9Sm56wzRM35FQ0+8nkwYVUrv9lzEoVd2NdOVvObfW
         jymw==
X-Gm-Message-State: APjAAAXX+/hQToTBE0wsEqY3R42aucckzg3n9FgSKqmNTJlNC2MSVPaf
        qlYPOhzBM2pS0ViOxWm5eAA6JQ==
X-Google-Smtp-Source: APXvYqy2j8z4zrv6pixCYXtdwfDCHIPHcMSlZiyOi4PqRbOW14W0q0tt/ziIhir+mKB+jiKw5TxZRQ==
X-Received: by 2002:adf:f743:: with SMTP id z3mr4041566wrp.200.1573067516685;
        Wed, 06 Nov 2019 11:11:56 -0800 (PST)
Received: from google.com ([100.105.32.75])
        by smtp.gmail.com with ESMTPSA id p14sm16143410wrq.72.2019.11.06.11.11.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2019 11:11:55 -0800 (PST)
Date:   Wed, 6 Nov 2019 20:11:49 +0100
From:   Marco Elver <elver@google.com>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Alexander Potapenko <glider@google.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Boqun Feng <boqun.feng@gmail.com>,
        Borislav Petkov <bp@alien8.de>, Daniel Axtens <dja@axtens.net>,
        Daniel Lustig <dlustig@nvidia.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Howells <dhowells@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Joel Fernandes <joel@joelfernandes.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Luc Maranget <luc.maranget@inria.fr>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicholas Piggin <npiggin@gmail.com>, paulmck@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-efi@vger.kernel.org,
        "open list:KERNEL BUILD + fi..." <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: [PATCH v3 1/9] kcsan: Add Kernel Concurrency Sanitizer
 infrastructure
Message-ID: <20191106191149.GA126960@google.com>
References: <20191104142745.14722-1-elver@google.com>
 <20191104142745.14722-2-elver@google.com>
 <CACT4Y+a+ftjHnRx9PD48hEVm98muooHwO0Y7i3cHetTJobRDxg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+a+ftjHnRx9PD48hEVm98muooHwO0Y7i3cHetTJobRDxg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On Wed, 06 Nov 2019, Dmitry Vyukov wrote:

> On Mon, Nov 4, 2019 at 3:28 PM Marco Elver <elver@google.com> wrote:
> >
> > Kernel Concurrency Sanitizer (KCSAN) is a dynamic data-race detector for
> > kernel space. KCSAN is a sampling watchpoint-based data-race detector.
> > See the included Documentation/dev-tools/kcsan.rst for more details.
> ...
> > +static inline atomic_long_t *find_watchpoint(unsigned long addr, size_t size,
> > +                                            bool expect_write,
> > +                                            long *encoded_watchpoint)
> > +{
> > +       const int slot = watchpoint_slot(addr);
> > +       const unsigned long addr_masked = addr & WATCHPOINT_ADDR_MASK;
> > +       atomic_long_t *watchpoint;
> > +       unsigned long wp_addr_masked;
> > +       size_t wp_size;
> > +       bool is_write;
> > +       int i;
> > +
> > +       BUILD_BUG_ON(CONFIG_KCSAN_NUM_WATCHPOINTS < CHECK_NUM_SLOTS);
> > +
> > +       for (i = 0; i < CHECK_NUM_SLOTS; ++i) {
> > +               watchpoint = &watchpoints[SLOT_IDX(slot, i)];
> 
> 
> The fast path code become much nicer!
> I did another pass looking at how we can optimize the fast path.
> Currently we still have 2 push/pop pairs on the fast path because of
> register pressure. The logic in SLOT_IDX seems to be the main culprit.
> We discussed several options offline:
> 1. Just check 1 slot and ignore all corner cases (we will miss racing
> unaligned access to different addresses but overlapping and crossing
> pages, which sounds pretty esoteric)
> 2. Check 3 slots in order and without wraparound (watchpoints[slot +
> i], where i=-1,0,1), this will require adding dummy slots around the
> array
> 3. An interesting option is to check just 2 slots (that's enough!), to
> make this work we will need to slightly offset bucket number when
> setting a watch point (namely, if an access goes to the very end of a
> page, we set the watchpoint into the bucket corresponding to the
> _next_ page)
> All of these options remove push/pop in my experiments. Obviously
> checking fewer slots will reduce dynamic overhead even more.
> 
> 
> > +               *encoded_watchpoint = atomic_long_read(watchpoint);
> > +               if (!decode_watchpoint(*encoded_watchpoint, &wp_addr_masked,
> > +                                      &wp_size, &is_write))
> > +                       continue;
> > +
> > +               if (expect_write && !is_write)
> > +                       continue;
> > +
> > +               /* Check if the watchpoint matches the access. */
> > +               if (matching_access(wp_addr_masked, wp_size, addr_masked, size))
> > +                       return watchpoint;
> > +       }
> > +
> > +       return NULL;
> > +}
> > +
> > +static inline atomic_long_t *insert_watchpoint(unsigned long addr, size_t size,
> > +                                              bool is_write)
> > +{
> > +       const int slot = watchpoint_slot(addr);
> > +       const long encoded_watchpoint = encode_watchpoint(addr, size, is_write);
> > +       atomic_long_t *watchpoint;
> > +       int i;
> > +
> > +       for (i = 0; i < CHECK_NUM_SLOTS; ++i) {
> > +               long expect_val = INVALID_WATCHPOINT;
> > +
> > +               /* Try to acquire this slot. */
> > +               watchpoint = &watchpoints[SLOT_IDX(slot, i)];
> 
> If we do this SLOT_IDX trickery to catch unaligned accesses crossing
> pages, then I think we should not use it insert_watchpoint at all and
> only set the watchpoint to the exact index. Otherwise, we will
> actually miss the corner cases which defeats the whole purpose of
> SLOT_IDX and 3 iterations.
> 

Just for the record, there are 2 reasons actually I decided to do this:

1. the address slot is already occupied, check if any adjacent slots are
   free;
2. accesses that straddle a slot boundary due to size that exceeds a
   slot's range may check adjacent slots if any watchpoint matches.

In /sys/kernel/debug/kcsan I can see no_capacity with the current version stays
below 10 for kernel boot. When I just use 1 slot, no_capacity events exceed
90000, because point (1) is no longer addressed. This is a problem that would
impair our ability to detect races.  One reason this happens is due to
locality: it is just much more likely that we have multiple accesses to the
same pages during some phase of execution from multiple threads.

To avoid blowing up no_capacity events, insert_watchpoint should not change. I
will change the iteration order in the fast-path (avoiding the complicated
logic), and add additional overflow entries to the watchpoint array.

AFAIK this generates better code, while still addressing points (1) and
(2) above. This should be the best trade-off between absolute
performance and our ability to detect data races.

-- Marco
