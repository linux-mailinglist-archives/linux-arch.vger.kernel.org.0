Return-Path: <linux-arch+bounces-13666-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7978B7E9F9
	for <lists+linux-arch@lfdr.de>; Wed, 17 Sep 2025 14:55:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B333326263
	for <lists+linux-arch@lfdr.de>; Wed, 17 Sep 2025 02:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38C202D8DB5;
	Wed, 17 Sep 2025 02:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UZpT05AK"
X-Original-To: linux-arch@vger.kernel.org
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8757421B19D;
	Wed, 17 Sep 2025 02:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758075267; cv=none; b=VjEeehsOz783wVg9Y7ZuDfwd+LLuil7yWtHd8UssDHMErBQpn6dXjAvM5JftpKEri5Wml0zeyVwsUnlPz2VGAS1FGUU3zm8dxoEclMMVEMlNpCbykPL5qQkZVPfiKbxaYfRO8oa1uYdGv81hGuSfAi1B4zUAchNv2z6mXZWQqgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758075267; c=relaxed/simple;
	bh=5LxSRnZ97w6Hp8IUAKhx0XjBcELN6mDC2ZegylN/AaM=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=SLqHkEYtn9fojL0qlAFEm67puQUru34B+vMxC/HNRSA20+1LVwwQN2H+rqmGVmJ9Q5yFj5sqZQ/3N0mr7vktGw8HyOjJhUElQ/o6lg1fIHksgM+wL1IV/juTQYycTqbshqm3HRvAGWFr8Wq2YsFkowUEww4GBgo/ruIGdmAW3/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UZpT05AK; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 88D9DEC016F;
	Tue, 16 Sep 2025 22:14:23 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 16 Sep 2025 22:14:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758075263; x=1758161663; bh=gdaTx7kX1iHBNYAuzwGMqdj/gpuqtHzY5DX
	LZIgxKLE=; b=UZpT05AKhWpIq3clIVrKfyUrBNX3mUaHLBHE6B/95rQpA8HCsqV
	xvQ+HLWyZFCmMTZ/lwKRrSBQ02u3FDt76FxPpgQs8lzMc4LgholuO0SHMsOGWCSA
	5uDNv4nuGsTP0x8YJuDvBum8LARsTKnnaEyStCJLj5JQyjDPCUppZQPurph0hkEF
	7BPzDPkeY8AaC3k6Ar/juavBkVT8XgadGJ1HPjSgqkxhqmtoh9tdBNXVTk/WorlR
	jzfRCG7nOSWyjedCJTBfdndb3ECmB1mKCsek0BJ+BTNVZtr+2n8crlfQcqJuVAtJ
	y66HyBOlrAnTsmiFM6o3T9pxYS0JlXeAN0g==
X-ME-Sender: <xms:fxnKaC-K1x8B-FTX2TwtTHYgMmCqp-uey6WpixOqO6D1AADJX-J5pA>
    <xme:fxnKaB4rCyrB2DnRdS2R4egpuJOJ8mslmklm_rw6tyLQXQhj9Wx4MJPH59GiyG1PC
    SWfNAmvDNrCyPWJ0-o>
X-ME-Received: <xmr:fxnKaKu6V3DnNzxxi5Mh-lIVT_U-4KHRESu0L0BHv0tW7ODPN_zOjqF2WiIXmBqYhiaXr8APbOK5QR530oNJQMmGnl2Y1y4wZgE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegvddvvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefujgfkfhggtgesthdtredttddtvdenucfhrhhomhephfhinhhnucfvhhgr
    ihhnuceofhhthhgrihhnsehlihhnuhigqdhmieekkhdrohhrgheqnecuggftrfgrthhtvg
    hrnhepfeejvdejieffvdehveevtdduudekhfetgfellefhfeetueeiudfhieevffdtgfdu
    necuffhomhgrihhnpehprghsthgvsghinhdrtghomhenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehfthhhrghinheslhhinhhugidqmheikehk
    rdhorhhgpdhnsggprhgtphhtthhopeduuddpmhhouggvpehsmhhtphhouhhtpdhrtghpth
    htoheprghrnhgusegrrhhnuggsrdguvgdprhgtphhtthhopehpvghtvghriiesihhnfhhr
    rgguvggrugdrohhrghdprhgtphhtthhopeifihhllheskhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtoheprghkphhmsehlihhnuhigqdhfohhunhgurghtihhonhdrohhrghdprhgtphht
    thhopegsohhquhhnrdhfvghnghesghhmrghilhdrtghomhdprhgtphhtthhopegtohhrsg
    gvtheslhifnhdrnhgvthdprhgtphhtthhopehmrghrkhdrrhhuthhlrghnugesrghrmhdr
    tghomhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopehlihhnuhigqdgrrhgthhesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:fxnKaD1WBc-2z2GbNyxvATA8pWAsdXMzYphiq-3aDlHHx5qCwr71_w>
    <xmx:fxnKaDrDqomGp-54dw9wh01lyFmPaltAF6cGzDVSja-rwDxf85B1Lw>
    <xmx:fxnKaDLSHZWPfD89Iw8UFTPTxPOuZ6zqOpm2hlR_NhHlVcSzG3htKA>
    <xmx:fxnKaPQ8opWxFmLcam0a0Ou8vRW02TICF4-j_LkIFEBMDwWkux4f7A>
    <xmx:fxnKaB35FKj4whumaTg3RbtjiXapipKqQBq9GIbNH6o2A6KGq8WI5aAA>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 16 Sep 2025 22:14:19 -0400 (EDT)
Date: Wed, 17 Sep 2025 12:14:15 +1000 (AEST)
From: Finn Thain <fthain@linux-m68k.org>
To: Arnd Bergmann <arnd@arndb.de>
cc: Peter Zijlstra <peterz@infradead.org>, Will Deacon <will@kernel.org>, 
    Andrew Morton <akpm@linux-foundation.org>, 
    Boqun Feng <boqun.feng@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
    Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org, 
    Linux-Arch <linux-arch@vger.kernel.org>, 
    Geert Uytterhoeven <geert@linux-m68k.org>, linux-m68k@vger.kernel.org
Subject: Re: [RFC v2 3/3] atomic: Add alignment check to instrumented atomic
 operations
In-Reply-To: <534e8ff8-70cb-4b78-b0b4-f88645bd180a@app.fastmail.com>
Message-ID: <0d93c6e5-a4cb-2f5c-e87d-e42a283324d6@linux-m68k.org>
References: <cover.1757810729.git.fthain@linux-m68k.org> <e5a38b0ccf2d37185964a69b6e8657c992966ff7.1757810729.git.fthain@linux-m68k.org> <20250915080054.GS3419281@noisy.programming.kicks-ass.net> <4b687706-a8f1-5f51-6e64-6eb09ae3eb5b@linux-m68k.org>
 <20250915100604.GZ3245006@noisy.programming.kicks-ass.net> <8247e3bd-13c2-e28c-87d8-5fd1bfed7104@linux-m68k.org> <57bca164-4e63-496d-9074-79fd89feb835@app.fastmail.com> <1c9095f5-df5c-2129-df11-877a03a205ab@linux-m68k.org>
 <534e8ff8-70cb-4b78-b0b4-f88645bd180a@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii


On Tue, 16 Sep 2025, Arnd Bergmann wrote:

> On Tue, Sep 16, 2025, at 02:16, Finn Thain wrote:
> 
> > Packing uapi structures (and adopting -malign-int) sounds easier than 
> > the alternative, which might be to align certain internal kernel 
> > struct members, on a case-by-case basis, where doing so could be shown 
> > to improve performance on some architecture or other (while keeping 
> > -mno-align-int).
> >
> > Well, it's easy to find all the structs that belong to the uapi, but 
> > it's not easy to find all the internal kernel structs that describe 
> > MMIO registers. For -malign-int, both kinds of structs are a problem.
> 
> Right, especially since those structure definitions are more likely to 
> be used on older drivers, there are probably some that do happen on 
> m68k. On the other hand, any driver that is portable to non-m68k targets 
> won't have this problem.
> 

Yes, but only inasmuchas drivers are completely portable. Any data 
structure accessed or declared using #if conditional code would defeat 
that kind of reasoning.

> I tried a trivial m68k defconfig build with "-Wpadded -malign-int" and 
> found 3021 instances of structure padding, compared to 2271 without 
> -malign-int. That is still something one could very reasonably go 
> through with 'vim -q output', as almost all of them are obviously 
> kernel-internal structures and not problematic.
> 

So, 3021 is the number of structs potentially needing to be checked? This 
is not the kind of upper bound I consider feasible for careful manual 
editing (it's worse than I thought). We need the compiler to help.

> A quick manual scan only shows a number of uapi structures but very few 
> drivers. There are a few hardware structures that are internally packed 
> but in a structure that has gets an extra two bytes of harmless padding 
> at the end (struct CUSTOM, struct amiga_hw_present, struct 
> atari_hw_present, struct TT_DMA, struct ppc_regs). 

I wouldn't assume that padding at the end is inconsequential. I think the 
analysis requires comparing object code. E.g. add the same padding 
explicitly to see whether it alters object code under -mno-align-int.

> The only ones I could find that actually seemed suspicious are:
> 
> arch/m68k/include/asm/atarihw.h:426:10: warning: padding struct to align 
> 'dst_address' [-Wpadded] arch/m68k/include/asm/openprom.h:76:13: 
> warning: padding struct to align 'boot_dev_ctrl' [-Wpadded] 
> drivers/net/ethernet/i825xx/82596.c:250:1: warning: padding struct size 
> to alignment boundary
> 
> I'm sure there are a few more, but probably not a lot more. See 
> https://pastebin.com/Z2bjnD0G for the full list. I've also tried 
> annotating the ones that show up in defconfig, see diffstat below.
> 
> Unfortunately I found no way of annotating a struct a whole to use the 
> traditional padding rules: "#pragma pack(push, 2)" lowers the alignment 
> of all struct members to two bytes, including those with an explicit 
> alignment like __aligned_u64. A struct-wide __attribute__((packed, 
> aligned(2))) seems even worse, as it makes all members inside of the 
> struck tightly packed and only aligns the struct itself.
> 
> This means all misaligned members have to be individually marked as 
> __packed, unless someone comes up with another type of annotation.
> 

Right. The trick will be to annotate the affected struct members by 
automatic program transformation.

> > If better performance is to be had, my guess is that aligning atomic_t 
> > will get 80% of it (just an appeal to the Pareto principle, FWIW...)
> 
> arch/m68k selects CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS for anything 
> other than Dragonball, so I would not expect much performance difference 
> at all, unless CASL on unaligned data ends up causing alignment traps as 
> it does on most architectures.
> 

I think the answer to the performance question would depend on both choice 
of workload and choice of architecture. I haven't done any measurements on 
this patch series yet.

>      Arnd
> 
>  arch/m68k/atari/atakeyb.c                          |  2 +-
>  arch/m68k/include/asm/amigahw.h                    |  4 +--
>  arch/m68k/include/asm/atarihw.h                    |  6 ++--
>  arch/m68k/include/asm/mvme147hw.h                  |  2 +-
>  arch/m68k/include/asm/openprom.h                   |  2 +-
>  arch/m68k/include/uapi/asm/ptrace.h                |  2 +-
>  arch/m68k/include/uapi/asm/sigcontext.h            |  2 +-
>  arch/m68k/include/uapi/asm/stat.h                  |  4 +--
>  drivers/net/ethernet/i825xx/82596.c                |  4 +--
>  include/uapi/asm-generic/termios.h                 |  2 +-
>  include/uapi/linux/acct.h                          |  2 +-
>  include/uapi/linux/ax25.h                          |  6 ++--
>  include/uapi/linux/blktrace_api.h                  |  2 +-
>  include/uapi/linux/btrfs.h                         |  2 +-
>  include/uapi/linux/cdrom.h                         | 36 +++++++++++-----------
>  include/uapi/linux/dlm.h                           |  2 +-
>  include/uapi/linux/dqblk_xfs.h                     |  2 +-
>  include/uapi/linux/ethtool.h                       | 14 ++++-----
>  include/uapi/linux/fb.h                            |  6 ++--
>  include/uapi/linux/fd.h                            |  6 ++--
>  include/uapi/linux/filter.h                        |  2 +-
>  include/uapi/linux/hdlc/ioctl.h                    |  6 ++--
>  include/uapi/linux/hiddev.h                        |  2 +-
>  include/uapi/linux/i2c-dev.h                       |  2 +-
>  include/uapi/linux/i2c.h                           |  2 +-
>  include/uapi/linux/if.h                            |  2 +-
>  include/uapi/linux/if_arcnet.h                     |  4 +--
>  include/uapi/linux/if_bonding.h                    |  2 +-
>  include/uapi/linux/if_bridge.h                     | 14 ++++-----
>  include/uapi/linux/if_link.h                       |  2 +-
>  include/uapi/linux/if_plip.h                       |  2 +-
>  include/uapi/linux/if_pppox.h                      |  2 +-
>  include/uapi/linux/if_vlan.h                       |  2 +-
>  include/uapi/linux/inet_diag.h                     |  2 +-
>  include/uapi/linux/input.h                         |  4 +--
>  include/uapi/linux/ip6_tunnel.h                    |  4 +--
>  include/uapi/linux/kd.h                            |  2 +-
>  include/uapi/linux/llc.h                           |  2 +-
>  include/uapi/linux/loop.h                          |  2 +-
>  include/uapi/linux/mctp.h                          |  4 +--
>  include/uapi/linux/mptcp.h                         |  2 +-
>  include/uapi/linux/mroute.h                        |  4 +--
>  include/uapi/linux/mroute6.h                       |  6 ++--
>  include/uapi/linux/msdos_fs.h                      |  2 +-
>  include/uapi/linux/msg.h                           |  6 ++--
>  include/uapi/linux/mtio.h                          |  2 +-
>  include/uapi/linux/netfilter/ipset/ip_set.h        |  4 +--
>  include/uapi/linux/netfilter/nf_nat.h              |  2 +-
>  include/uapi/linux/netfilter/x_tables.h            |  8 ++---
>  include/uapi/linux/netfilter/xt_HMARK.h            |  2 +-
>  include/uapi/linux/netfilter/xt_TPROXY.h           |  4 +--
>  include/uapi/linux/netfilter/xt_connbytes.h        |  2 +-
>  include/uapi/linux/netfilter/xt_connmark.h         |  6 ++--
>  include/uapi/linux/netfilter/xt_conntrack.h        |  4 +--
>  include/uapi/linux/netfilter/xt_esp.h              |  2 +-
>  include/uapi/linux/netfilter/xt_hashlimit.h        |  6 ++--
>  include/uapi/linux/netfilter/xt_helper.h           |  2 +-
>  include/uapi/linux/netfilter/xt_ipcomp.h           |  2 +-
>  include/uapi/linux/netfilter/xt_iprange.h          |  2 +-
>  include/uapi/linux/netfilter/xt_l2tp.h             |  2 +-
>  include/uapi/linux/netfilter/xt_mac.h              |  2 +-
>  include/uapi/linux/netfilter/xt_mark.h             |  2 +-
>  include/uapi/linux/netfilter/xt_owner.h            |  2 +-
>  include/uapi/linux/netfilter/xt_realm.h            |  2 +-
>  include/uapi/linux/netfilter/xt_recent.h           |  4 +--
>  include/uapi/linux/netfilter/xt_set.h              |  4 +--
>  include/uapi/linux/netfilter/xt_statistic.h        |  2 +-
>  include/uapi/linux/netfilter/xt_tcpmss.h           |  2 +-
>  include/uapi/linux/netfilter/xt_tcpudp.h           |  2 +-
>  include/uapi/linux/netfilter/xt_time.h             |  2 +-
>  include/uapi/linux/netfilter/xt_u32.h              |  6 ++--
>  include/uapi/linux/netfilter_arp/arp_tables.h      |  2 +-
>  include/uapi/linux/netfilter_arp/arpt_mangle.h     |  2 +-
>  include/uapi/linux/netfilter_bridge/ebt_802_3.h    |  2 +-
>  include/uapi/linux/netfilter_bridge/ebt_arp.h      |  2 +-
>  include/uapi/linux/netfilter_bridge/ebt_arpreply.h |  2 +-
>  include/uapi/linux/netfilter_bridge/ebt_mark_m.h   |  2 +-
>  include/uapi/linux/netfilter_bridge/ebt_nat.h      |  2 +-
>  include/uapi/linux/netfilter_bridge/ebt_stp.h      |  4 +--
>  include/uapi/linux/netfilter_bridge/ebt_vlan.h     |  2 +-
>  include/uapi/linux/netfilter_ipv4/ipt_ah.h         |  2 +-
>  include/uapi/linux/netfilter_ipv6/ip6_tables.h     |  2 +-
>  include/uapi/linux/netfilter_ipv6/ip6t_ah.h        |  2 +-
>  include/uapi/linux/netfilter_ipv6/ip6t_frag.h      |  2 +-
>  include/uapi/linux/netfilter_ipv6/ip6t_opts.h      |  2 +-
>  include/uapi/linux/netfilter_ipv6/ip6t_rt.h        |  2 +-
>  include/uapi/linux/netfilter_ipv6/ip6t_srh.h       |  2 +-
>  include/uapi/linux/netrom.h                        |  2 +-
>  include/uapi/linux/nfs_idmap.h                     |  2 +-
>  include/uapi/linux/nfs_mount.h                     |  2 +-
>  include/uapi/linux/pkt_cls.h                       |  2 +-
>  include/uapi/linux/rds.h                           |  4 +--
>  include/uapi/linux/rose.h                          |  8 ++---
>  include/uapi/linux/route.h                         |  2 +-
>  include/uapi/linux/rtc.h                           |  2 +-
>  include/uapi/linux/sctp.h                          | 18 +++++------
>  include/uapi/linux/sed-opal.h                      |  2 +-
>  include/uapi/linux/sem.h                           |  2 +-
>  include/uapi/linux/serial.h                        |  4 +--
>  include/uapi/linux/soundcard.h                     |  8 ++---
>  include/uapi/linux/taskstats.h                     |  2 +-
>  include/uapi/linux/virtio_net.h                    |  4 +--
>  include/uapi/linux/wireless.h                      |  4 +--
>  include/uapi/linux/xfrm.h                          | 26 ++++++++--------
>  include/uapi/mtd/mtd-abi.h                         |  2 +-
>  include/uapi/rdma/hfi/hfi1_ioctl.h                 |  2 +-
>  include/uapi/rdma/ib_user_ioctl_verbs.h            |  2 +-
>  include/uapi/rdma/ib_user_mad.h                    |  2 +-
>  109 files changed, 205 insertions(+), 204 deletions(-)
> 

Thanks for sending these results. I was looking into doing something 
similar using pahole but found that difficult. When I #include'd all the 
headers of interest, the thing doesn't build. I abandoned that approach 
and concluded that the way forward was to get the compiler to do the 
analysis (perhaps with a plug-in), during a normal kernel build, rather 
than during compilation of some contrived mess containing all the headers 
and all the structs.

It would be sufficient to have a plug-in to list the sites of all members 
potentially needing annnotation. The list could be manually pared down and 
the actual annotating could be scripted. Note that this list would be 
shorter than a -Wpadded list, because there's a bunch of padding that's 
not relevant.

