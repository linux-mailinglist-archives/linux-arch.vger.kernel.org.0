Return-Path: <linux-arch+bounces-1038-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCD5881351B
	for <lists+linux-arch@lfdr.de>; Thu, 14 Dec 2023 16:45:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45F391F21843
	for <lists+linux-arch@lfdr.de>; Thu, 14 Dec 2023 15:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E26F5D8FD;
	Thu, 14 Dec 2023 15:45:41 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6ADFB9A;
	Thu, 14 Dec 2023 07:45:37 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9BF2AC15;
	Thu, 14 Dec 2023 07:46:22 -0800 (PST)
Received: from raptor (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EA4D93F5A1;
	Thu, 14 Dec 2023 07:45:31 -0800 (PST)
Date: Thu, 14 Dec 2023 15:45:25 +0000
From: Alexandru Elisei <alexandru.elisei@arm.com>
To: Rob Herring <robh@kernel.org>
Cc: catalin.marinas@arm.com, will@kernel.org, oliver.upton@linux.dev,
	maz@kernel.org, james.morse@arm.com, suzuki.poulose@arm.com,
	yuzenghui@huawei.com, arnd@arndb.de, akpm@linux-foundation.org,
	mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	bristot@redhat.com, vschneid@redhat.com, mhiramat@kernel.org,
	rppt@kernel.org, hughd@google.com, pcc@google.com,
	steven.price@arm.com, anshuman.khandual@arm.com,
	vincenzo.frascino@arm.com, david@redhat.com, eugenis@google.com,
	kcc@google.com, hyesoo.yu@samsung.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH RFC v2 11/27] arm64: mte: Reserve tag storage memory
Message-ID: <ZXsjFYKHkJM_JLCy@raptor>
References: <20231119165721.9849-12-alexandru.elisei@arm.com>
 <CAL_Jsq+k5BeM9+u12AQvWQ0b4Uv5Cy0vPOpK_uLcYtRnunq4iQ@mail.gmail.com>
 <ZXiMiLz9ZyUdxUP8@raptor>
 <CAL_Jsq+U_GR=mOK3-phnd4jeJKf79aOmhPwDOSj+f=s-7fZZWQ@mail.gmail.com>
 <ZXmr-Kl9L2SO13--@raptor>
 <CAL_JsqL=P1Y6w38LD_xw+vK4CNqt22FW_FE9oi_XTLHVQEne7Q@mail.gmail.com>
 <ZXnE3724jYYSg4o6@raptor>
 <CAL_JsqJgTnuQjo13cKo1Ebm5j9tCRT8GhNavdqu5vwp+fdnTLw@mail.gmail.com>
 <ZXnthcg0BkEd-RgK@raptor>
 <CAL_JsqLAW0--F8R0oTaajN3YpbK2KgE6Ypn8tk4_pf_s=xC+aw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL_JsqLAW0--F8R0oTaajN3YpbK2KgE6Ypn8tk4_pf_s=xC+aw@mail.gmail.com>

Hi,

On Wed, Dec 13, 2023 at 02:30:42PM -0600, Rob Herring wrote:
> On Wed, Dec 13, 2023 at 11:44 AM Alexandru Elisei
> <alexandru.elisei@arm.com> wrote:
> >
> > On Wed, Dec 13, 2023 at 11:22:17AM -0600, Rob Herring wrote:
> > > On Wed, Dec 13, 2023 at 8:51 AM Alexandru Elisei
> > > <alexandru.elisei@arm.com> wrote:
> > > >
> > > > Hi,
> > > >
> > > > On Wed, Dec 13, 2023 at 08:06:44AM -0600, Rob Herring wrote:
> > > > > On Wed, Dec 13, 2023 at 7:05 AM Alexandru Elisei
> > > > > <alexandru.elisei@arm.com> wrote:
> > > > > >
> > > > > > Hi Rob,
> > > > > >
> > > > > > On Tue, Dec 12, 2023 at 12:44:06PM -0600, Rob Herring wrote:
> > > > > > > On Tue, Dec 12, 2023 at 10:38 AM Alexandru Elisei
> > > > > > > <alexandru.elisei@arm.com> wrote:
> > > > > > > >
> > > > > > > > Hi Rob,
> > > > > > > >
> > > > > > > > Thank you so much for the feedback, I'm not very familiar with device tree,
> > > > > > > > and any comments are very useful.
> > > > > > > >
> > > > > > > > On Mon, Dec 11, 2023 at 11:29:40AM -0600, Rob Herring wrote:
> > > > > > > > > On Sun, Nov 19, 2023 at 10:59 AM Alexandru Elisei
> > > > > > > > > <alexandru.elisei@arm.com> wrote:
> > > > > > > > > >
> > > > > > > > > > Allow the kernel to get the size and location of the MTE tag storage
> > > > > > > > > > regions from the DTB. This memory is marked as reserved for now.
> > > > > > > > > >
> > > > > > > > > > The DTB node for the tag storage region is defined as:
> > > > > > > > > >
> > > > > > > > > >         tags0: tag-storage@8f8000000 {
> > > > > > > > > >                 compatible = "arm,mte-tag-storage";
> > > > > > > > > >                 reg = <0x08 0xf8000000 0x00 0x4000000>;
> > > > > > > > > >                 block-size = <0x1000>;
> > > > > > > > > >                 memory = <&memory0>;    // Associated tagged memory node
> > > > > > > > > >         };
> > > > > > > > >
> > > > > > > > > I skimmed thru the discussion some. If this memory range is within
> > > > > > > > > main RAM, then it definitely belongs in /reserved-memory.
> > > > > > > >
> > > > > > > > Ok, will do that.
> > > > > > > >
> > > > > > > > If you don't mind, why do you say that it definitely belongs in
> > > > > > > > reserved-memory? I'm not trying to argue otherwise, I'm curious about the
> > > > > > > > motivation.
> > > > > > >
> > > > > > > Simply so that /memory nodes describe all possible memory and
> > > > > > > /reserved-memory is just adding restrictions. It's also because
> > > > > > > /reserved-memory is what gets handled early, and we don't need
> > > > > > > multiple things to handle early.
> > > > > > >
> > > > > > > > Tag storage is not DMA and can live anywhere in memory.
> > > > > > >
> > > > > > > Then why put it in DT at all? The only reason CMA is there is to set
> > > > > > > the size. It's not even clear to me we need CMA in DT either. The
> > > > > > > reasoning long ago was the kernel didn't do a good job of moving and
> > > > > > > reclaiming contiguous space, but that's supposed to be better now (and
> > > > > > > most h/w figured out they need IOMMUs).
> > > > > > >
> > > > > > > But for tag storage you know the size as it is a function of the
> > > > > > > memory size, right? After all, you are validating the size is correct.
> > > > > > > I guess there is still the aspect of whether you want enable MTE or
> > > > > > > not which could be done in a variety of ways.
> > > > > >
> > > > > > Oh, sorry, my bad, I should have been clearer about this. I don't want to
> > > > > > put it in the DT as a "linux,cma" node. But I want it to be managed by CMA.
> > > > >
> > > > > Yes, I understand, but my point remains. Why do you need this in DT?
> > > > > If the location doesn't matter and you can calculate the size from the
> > > > > memory size, what else is there to add to the DT?
> > > >
> > > > I am afraid there has been a misunderstanding. What do you mean by
> > > > "location doesn't matter"?
> > >
> > > You said:
> > > > Tag storage is not DMA and can live anywhere in memory.
> > >
> > > Which I took as the kernel can figure out where to put it. But maybe
> > > you meant the h/w platform can hard code it to be anywhere in memory?
> > > If so, then yes, DT is needed.
> >
> > Ah, I see, sorry for not being clear enough, you are correct: tag storage
> > is a hardware property, and software needs a mechanism (in this case, the
> > dt) to discover its properties.
> >
> > >
> > > > At the very least, Linux needs to know the address and size of a memory
> > > > region to use it. The series is about using the tag storage memory for
> > > > data. Tag storage cannot be described as a regular memory node because it
> > > > cannot be tagged (and normal memory can).
> > >
> > > If the tag storage lives in the middle of memory, then it would be
> > > described in the memory node, but removed by being in reserved-memory
> > > node.
> >
> > I don't follow. Would you mind going into more details?
> 
> It goes back to what I said earlier about /memory nodes describing all
> the memory. There's no reason to reserve memory if you haven't
> described that range as memory to begin with. One could presumably
> just have a memory node for each contiguous chunk and not need
> /reserved-memory (ignoring the need to say what things are reserved
> for). That would become very difficult to adjust. Note that the kernel
> has a hardcoded limit of 64 reserved regions currently and that is not
> enough for some people. Seems like a lot, but I have no idea how they
> are (ab)using /reserved-memory.

Ah, I see what you mean, reserved memory is about marking existing memory
(from a /memory node) as special, not about adding new memory.

After the memblock allocator is initialized, the kernel can use it for its
own allocations. Kernel allocations are not movable.

When a page is allocated as tagged, the associated tag storage cannot be
used for data, otherwise the tags would corrupt that data. To avoid this,
the requirement is that tag storage pages are only used for movable
allocations. When a page is allocated as tagged, the data in the associated
tag storage is migrated and the tag storage is taken from the page
allocator (via alloc_contig_range()).

My understanding is that the memblock allocator can use all the memory from
a /memory node. If the tags storage memory is declared in a /memory node,
there exists the possibility that Linux will use tag storage memory for its
own allocation, which would make that tags storage memory unmovable, and
thus unusable for storing tags.

Looking at early_init_dt_scan_memory(), even if a /memory node if marked at
hotpluggable, memblock will still use it, unless "movable_node" is set on
the kernel command line.

That's the reason why I'm not describing tag storage in a /memory node.  Is
there way to tell the memblock allocator not to use memory from a /memory
node?

> 
> Let me give an example. Presumably using MTE at all is configurable.
> If you boot a kernel with MTE disabled (or older and not supporting
> it), then I'd assume you'd want to use the tag storage for regular
> memory. Well, If tag storage is already part of /memory, then all you
> have to do is ignore the tag reserved-memory region. Tweaking the
> memory nodes would be more work.

Right now, memory is added via memblock_reserve(), and if MTE is disabled
(for example, via the kernel command line), the code calls
free_reserved_page() for each tag storage page. I find that straightfoward
to implement.

Thanks,
Alex

> 
> 
> Also, I should point out that /memory and /reserved-memory nodes are
> not used for UEFI boot.
> 
> Rob
> 

