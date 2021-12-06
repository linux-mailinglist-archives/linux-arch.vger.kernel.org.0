Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19B4446990A
	for <lists+linux-arch@lfdr.de>; Mon,  6 Dec 2021 15:32:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344515AbhLFOgR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 6 Dec 2021 09:36:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343717AbhLFOgR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 6 Dec 2021 09:36:17 -0500
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CE61C061746;
        Mon,  6 Dec 2021 06:32:48 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id c3so13146168iob.6;
        Mon, 06 Dec 2021 06:32:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FHezbGrYlKxA1aTrkxNXSkuk1RduKCiWsmFP87kNHNY=;
        b=GXfZLWErwVXNUIWTHzJ3JSvvaZ1ekUxwLx/RO6eG2oqG8RKwA83QEHyf6Lgu2pvH2e
         6EAZXpfRzfvbjY71KDHAzWFUD1D5xnfkxDwd1DAzcCl83aTQm6Ne32mTBtwoQgT1CHUV
         2W8cDfYJZTbjYPvaVlm+oBaInxz7hnYHaJtrKCW3ZUfFjBzMZQu8pSL7cZgSKpwByPwK
         gdOYhET5KSaY7yVXH/pmeLnQFr/R51Qxn+A8CxvMJ/5bQhb/CoYCURhE7gJQplzFUgS0
         HnBwT1uFanfIiFq2JoHW276Mrtt8WTSgmVf7U/BsIzKfQ9A9GkpI3mSaOpkBHdDcbQTZ
         Mhyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FHezbGrYlKxA1aTrkxNXSkuk1RduKCiWsmFP87kNHNY=;
        b=ENhmfjl4NnLq3ESXjO7YkZN38/qBXQO/ZCKTaOckHdABTUan9C4DUmbSOZ6y0pPCZy
         +Rqtxbn8WTvmzvqhJS9YR9e+AM65ewGFZNClcISC6I7xyVO/06tJOs2kQeiqTxozH52M
         XKU4HyFBfUt19IT78u2wGiK8g++kgrft1fPXmU+Nf/wREBHRES3HGg3ITWlZyGvhTUFv
         SlUpFUBHHREI1KyCA6oXjS3UzNs2SrfuH5aEss9hq6oRXhRiVTFtY4MASdM//7OheSpw
         e63o1tOScnlHAL08DjdN1arbCoKc9VGdoccx1zv3iKhzOrPvaSQGiHkk6fHCOZ6YaDBF
         i/4A==
X-Gm-Message-State: AOAM533ppt6gZ0q2zFOHb9iKHPxfXwZmvgYTEmVbP8l+5d58zJrGqvX2
        oOlsQbnkrZSCNoIiy/2hPF8=
X-Google-Smtp-Source: ABdhPJx2s79y4UV6UfCELoWwjsBXrn2U9Tro1XMfsLGc7m27xn/DOl5d0HW/E8jg1uMWElErsFJE7A==
X-Received: by 2002:a02:a708:: with SMTP id k8mr42965751jam.26.1638801167426;
        Mon, 06 Dec 2021 06:32:47 -0800 (PST)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id y8sm6337176iox.32.2021.12.06.06.32.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 06:32:46 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id 8E52D27C0054;
        Mon,  6 Dec 2021 09:32:44 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 06 Dec 2021 09:32:44 -0500
X-ME-Sender: <xms:Cx-uYQs85A1MMXJYGuWqEJ7Z5H0fYWyIBMsroi5ZcJYhDA_0sXEVKw>
    <xme:Cx-uYdeOOSQTLomCC91P6fvNfLUaBzynTvS8S1IJqe42v_kaQOsPATPLrlpxDh5K-
    VsJpX9OMQqwUGTEww>
X-ME-Received: <xmr:Cx-uYbxTazrQNhAmwOJDGcwBcZKt0G6ftpVDE7070sHyD2fzk1MP_1dE6sw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrjeefgdeihecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtth
    gvrhhnpeevieejtdfhieejfeduheehvdevgedugeethefggfdtvdeutdevgeetvddvfeeg
    tdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgv
    rhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfh
    gvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:Cx-uYTP7IMvllYtCuW-96zpzDKmquPq_Oc0AMq8B6-3JLGB89W1FVQ>
    <xmx:Cx-uYQ-LAihlYOGwm6Zoiy1lOqxm_kftsSxg_LPN5by606Y0o4ftaA>
    <xmx:Cx-uYbVLvwYrqkFwFZoM7PbDfKREKDylKP9K-SP5OD6QDsGQMr7wcg>
    <xmx:DB-uYT3XFpOMXfNRE9xfxrXZdDXokmbhrddzAfQotajWX2sPWXYz3F-Xqns>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Dec 2021 09:32:43 -0500 (EST)
Date:   Mon, 6 Dec 2021 22:31:24 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Marco Elver <elver@google.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Alexander Potapenko <glider@google.com>,
        Borislav Petkov <bp@alien8.de>,
        Dmitry Vyukov <dvyukov@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Waiman Long <longman@redhat.com>,
        Will Deacon <will@kernel.org>, kasan-dev@googlegroups.com,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, llvm@lists.linux.dev, x86@kernel.org
Subject: Re: [PATCH v3 08/25] kcsan: Show location access was reordered to
Message-ID: <Ya4evHE7uQ9eXpax@boqun-archlinux>
References: <20211130114433.2580590-1-elver@google.com>
 <20211130114433.2580590-9-elver@google.com>
 <Ya2Zpf8qpgDYiGqM@boqun-archlinux>
 <CANpmjNMirKGSBW2m+bWRM9_FnjK3_HjnJC=dhyMktx50mwh1GQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNMirKGSBW2m+bWRM9_FnjK3_HjnJC=dhyMktx50mwh1GQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Dec 06, 2021 at 08:16:11AM +0100, Marco Elver wrote:
> On Mon, 6 Dec 2021 at 06:04, Boqun Feng <boqun.feng@gmail.com> wrote:
> >
> > Hi,
> >
> > On Tue, Nov 30, 2021 at 12:44:16PM +0100, Marco Elver wrote:
> > > Also show the location the access was reordered to. An example report:
> > >
> > > | ==================================================================
> > > | BUG: KCSAN: data-race in test_kernel_wrong_memorder / test_kernel_wrong_memorder
> > > |
> > > | read-write to 0xffffffffc01e61a8 of 8 bytes by task 2311 on cpu 5:
> > > |  test_kernel_wrong_memorder+0x57/0x90
> > > |  access_thread+0x99/0xe0
> > > |  kthread+0x2ba/0x2f0
> > > |  ret_from_fork+0x22/0x30
> > > |
> > > | read-write (reordered) to 0xffffffffc01e61a8 of 8 bytes by task 2310 on cpu 7:
> > > |  test_kernel_wrong_memorder+0x57/0x90
> > > |  access_thread+0x99/0xe0
> > > |  kthread+0x2ba/0x2f0
> > > |  ret_from_fork+0x22/0x30
> > > |   |
> > > |   +-> reordered to: test_kernel_wrong_memorder+0x80/0x90
> > > |
> >
> > Should this be "reordered from" instead of "reordered to"? For example,
> > if the following case needs a smp_mb() between write to A and write to
> > B, I think currently it will report as follow:
> >
> >         foo() {
> >                 WRITE_ONCE(A, 1); // let's say A's address is 0xaaaa
> >                 bar() {
> >                         WRITE_ONCE(B, 1); // Assume B's address is 0xbbbb
> >                                           // KCSAN find the problem here
> >                 }
> >         }
> >
> >         <report>
> >         | write (reordered) to 0xaaaa of ...:
> >         | bar+0x... // address of the write to B
> >         | foo+0x... // address of the callsite to bar()
> >         | ...
> >         |  |
> >         |  +-> reordered to: foo+0x... // address of the write to A
> >
> > But since the access reported here is the write to A, so it's a
> > "reordered from" instead of "reordered to"?
> 
> Perhaps I could have commented on this in the commit message to avoid
> the confusion, but per its updated comment replace_stack_entry()
> "skips to the first entry that matches the function of @ip, and then
> replaces that entry with @ip, returning the entries to skip with
> @replaced containing the replaced entry."
> 
> When a reorder_access is set up, the ip to it is stored, which is
> what's passed to @ip of replace_stack_entry(). It effectively swaps
> the top frame where the race occurred with where the original access
> happened. This all works because the runtime is careful to only keep
> reorder_accesses valid until the original function where it occurred
> is left.
> 

Thanks for the explanation, I was missing the swap here. However...

> So in your above example you need to swap "reordered to" and the top
> frame of the stack trace.
> 

IIUC, the report for my above example will be:

         | write (reordered) to 0xaaaa of ...:
         | foo+0x... // address of the write to A
         | ...
         |  |
         |  +-> reordered to: foo+0x... // address of the callsite to bar() in foo()

, right? Because in replace_stack_entry(), it's not the top frame where
the race occurred that gets swapped, it's the frame which belongs to the
same function as the original access that gets swapped. In other words,
when KCSAN finds the problem, top entries of the calling stack are:

	[0] bar+0x.. // address of the write to B
	[1] foo+0x.. // address of the callsite to bar() in foo()

after replace_stack_entry(), they changes to:

	[0] bar+0x.. // address of the write to B
skip  ->[1] foo+0x.. // address of the write to A

, as a result the report won't mention bar() at all.

And I think a better report will be:

         | write (reordered) to 0xaaaa of ...:
         | foo+0x... // address of the write to A
         | ...
         |  |
         |  +-> reordered to: bar+0x... // address of the write to B in bar()

because it tells users the exact place the accesses get reordered. That
means maybe we want something as below? Not completely tested, but I
play with scope checking a bit, seems it gives what I want. Thoughts?

Regards,
Boqun

diff --git a/kernel/kcsan/report.c b/kernel/kcsan/report.c
index 67794404042a..b495ed3aa637 100644
--- a/kernel/kcsan/report.c
+++ b/kernel/kcsan/report.c
@@ -324,7 +324,10 @@ replace_stack_entry(unsigned long stack_entries[], int num_entries, unsigned lon
        else
                goto fallback;

-       for (skip = 0; skip < num_entries; ++skip) {
+       skip = get_stack_skipnr(stack_entries, num_entries);
+       *replaced = stack_entries[skip];
+
+       for (;skip < num_entries; ++skip) {
                unsigned long func = stack_entries[skip];

                if (!kallsyms_lookup_size_offset(func, &symbolsize, &offset))
@@ -332,7 +335,6 @@ replace_stack_entry(unsigned long stack_entries[], int num_entries, unsigned lon
                func -= offset;

                if (func == target_func) {
-                       *replaced = stack_entries[skip];
                        stack_entries[skip] = ip;
                        return skip;
                }

> The implementation is a little trickier of course, but I really wanted
> the main stack trace to look like any other non-reordered access,
> which starts from the original access, and only have the "reordered
> to" location be secondary information.
> 
> The foundation for doing this this was put in place here:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=6c65eb75686f
> 
> Thanks,
> -- Marco
