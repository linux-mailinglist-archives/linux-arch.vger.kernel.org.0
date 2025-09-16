Return-Path: <linux-arch+bounces-13657-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE548B59659
	for <lists+linux-arch@lfdr.de>; Tue, 16 Sep 2025 14:38:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03C4F1BC3D43
	for <lists+linux-arch@lfdr.de>; Tue, 16 Sep 2025 12:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6025E30C61A;
	Tue, 16 Sep 2025 12:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="aNmO3Pob";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UEC3Q4OY"
X-Original-To: linux-arch@vger.kernel.org
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66BF630BF65;
	Tue, 16 Sep 2025 12:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758026289; cv=none; b=ijAR9XURcB0OsGnZBWrDmAZOuwzZ69QMLLrL5TABhZOQSRFaxzMvRKN98qE9ZrT8BFaRCqZ16hoVKW2JkYFewYiqGraLFIlUzK8BwhOrHJNhrNxmewmtv7/ri03bZ68yCAbkzeoJMofuhMpYQK5CkijuwgbXTVs33iaQ/j5Y+Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758026289; c=relaxed/simple;
	bh=HP0EtwHi3GYYbAlKpcPitJRQVxCLFOBSg/Ob4whwGkA=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=A3pY1Y6ufoAWA0dg4ZnFcR4prUKaf7f9ESPbDd/OWmhmHeMOetMbv6yikX8u9TqwmwLfmaaNzfOKOYl2RfIHurTZU730CzZd7xOioyM+nPmQW0Wd3rtRmegk1QTjzvTyQDF8kocKmV/nbn+77tVd1K/+6KM2kKRoEe4I9vZGG/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=aNmO3Pob; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UEC3Q4OY; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 434C11D002BC;
	Tue, 16 Sep 2025 08:38:05 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Tue, 16 Sep 2025 08:38:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1758026285;
	 x=1758112685; bh=LsX5t9gccjS16o2ILNjJEVNCm3CidZ51dGZaJlgA0HA=; b=
	aNmO3PobZc2iJqRBzBtBosh4byuA9RYvCwuduEdujehFowfsFgYXGbbuuPuhsG61
	tf0OZ86aXXvobL5kUYKBqItCfR3/GIL1sQwt0OSN5bsDoq++6axnp5RUIMLzlqW6
	FNiSOfWLIBAKL6yxgf5t8UC2WcvTZI2ZZ/crocqsttQAUn0LdICWL34JTxap7TAJ
	up3qDVbyxWoq+oosapkL0M7uF5jyuzCbf3Qe9ez3EveDhmoj2dxyWOEi/pAVp0C5
	JgOM2cTPC3XZpMfLtz7Cv2ZZzLQw5wcSdF4oSf8jf6W6VdziP3uffnf6EiQhllvi
	BySEp5wv7iB0ztjRduOy0g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758026285; x=
	1758112685; bh=LsX5t9gccjS16o2ILNjJEVNCm3CidZ51dGZaJlgA0HA=; b=U
	EC3Q4OYi2JwrsXu3OHNHPMRD8amgl1/LKq499DssbWdOQTFRBHJcl+r1fi2uPYIy
	c9b85ynGMtXlnhL+YumMCBSYab8Ce+o0640n6rPg/rCmTA23Xyux/C6e/KNG4mVq
	08ZAjogBdhzmwLkt92LbHHXZ5anCm+QpJvPvCs04f6xwRcO7qJ70iY8JdO69Jzk/
	VwmlZf+tX7Sp3/pX2D7Rysn3l/r4TsXYC9q+yeIHVnyFHDnpGGwkrKzUFHD4EEPa
	WWRvjf8bfqWcjrhAD5+nD6vXCZWhQ7XBEvCah1bT+80YvSoT8TP7GOPhmD9tINig
	Le9ipP/NIjFcWKW4Deg8Q==
X-ME-Sender: <xms:LFrJaJ3AcCICh2Hu43LZoEblFO0g4IjtUL0lpRd2mZ2cgiIk9zFoqg>
    <xme:LFrJaAEtwfWncuKKTz1XkRiv9F5PlGSY6U-uEBIARz6vVsILhqwkE5QTVH7LK7wCW
    KIWWwSXhsZZkfS8yiM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegtdehlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdetrhhnugcu
    uegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrh
    hnpeehjeejhfeftdfgieehleefleehgedugfevieeiveeivedvudegheehudefkefhfeen
    ucffohhmrghinhepphgrshhtvggsihhnrdgtohhmnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghr
    tghpthhtohepuddupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmrghrkhdrrh
    huthhlrghnugesrghrmhdrtghomhdprhgtphhtthhopegsohhquhhnrdhfvghnghesghhm
    rghilhdrtghomhdprhgtphhtthhopehpvghtvghriiesihhnfhhrrgguvggrugdrohhrgh
    dprhgtphhtthhopeifihhllheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghkphhm
    sehlihhnuhigqdhfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopehfthhhrghinh
    eslhhinhhugidqmheikehkrdhorhhgpdhrtghpthhtohepghgvvghrtheslhhinhhugidq
    mheikehkrdhorhhgpdhrtghpthhtoheptghorhgsvghtsehlfihnrdhnvghtpdhrtghpth
    htoheplhhinhhugidqrghrtghhsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:LFrJaHHjTEgrNZmohOM0zDsiLnPP7bABqFjNly-j-_iZYe-nTHCFJg>
    <xmx:LFrJaF6a7rlNS-HvirGtvYha_SZUrQ3ks0bAcIfn4raYZHkJbV1uPQ>
    <xmx:LFrJaIbEeqKN_E9_zmQq1Q-wkxYoJvdvo7-9lMRK3u8UOTEhZkwfQQ>
    <xmx:LFrJaLjiXAUaNHQZ9B_dP4LqvIaBzb-SmpIWYddVw5uYlVFRhxq0jQ>
    <xmx:LVrJaEmzIvqg_roFz_kCIDz_yuZ5PSD8XbPbDMMWaGE6yhS5g_B4cBQh>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 4C90370006A; Tue, 16 Sep 2025 08:38:04 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A-ya5D5_Z2ZZ
Date: Tue, 16 Sep 2025 14:37:21 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Finn Thain" <fthain@linux-m68k.org>
Cc: "Peter Zijlstra" <peterz@infradead.org>, "Will Deacon" <will@kernel.org>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "Boqun Feng" <boqun.feng@gmail.com>, "Jonathan Corbet" <corbet@lwn.net>,
 "Mark Rutland" <mark.rutland@arm.com>, linux-kernel@vger.kernel.org,
 Linux-Arch <linux-arch@vger.kernel.org>,
 "Geert Uytterhoeven" <geert@linux-m68k.org>, linux-m68k@vger.kernel.org
Message-Id: <534e8ff8-70cb-4b78-b0b4-f88645bd180a@app.fastmail.com>
In-Reply-To: <1c9095f5-df5c-2129-df11-877a03a205ab@linux-m68k.org>
References: <cover.1757810729.git.fthain@linux-m68k.org>
 <e5a38b0ccf2d37185964a69b6e8657c992966ff7.1757810729.git.fthain@linux-m68k.org>
 <20250915080054.GS3419281@noisy.programming.kicks-ass.net>
 <4b687706-a8f1-5f51-6e64-6eb09ae3eb5b@linux-m68k.org>
 <20250915100604.GZ3245006@noisy.programming.kicks-ass.net>
 <8247e3bd-13c2-e28c-87d8-5fd1bfed7104@linux-m68k.org>
 <57bca164-4e63-496d-9074-79fd89feb835@app.fastmail.com>
 <1c9095f5-df5c-2129-df11-877a03a205ab@linux-m68k.org>
Subject: Re: [RFC v2 3/3] atomic: Add alignment check to instrumented atomic operations
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Sep 16, 2025, at 02:16, Finn Thain wrote:
> On Mon, 15 Sep 2025, Arnd Bergmann wrote:
>
>> IIRC there are only a small number of uapi structures that need
>> __packed annotations to maintain the existing syscall ABI.
>> 
>
> Packing uapi structures (and adopting -malign-int) sounds easier than the 
> alternative, which might be to align certain internal kernel struct 
> members, on a case-by-case basis, where doing so could be shown to improve 
> performance on some architecture or other (while keeping -mno-align-int).
>
> Well, it's easy to find all the structs that belong to the uapi, but it's 
> not easy to find all the internal kernel structs that describe MMIO 
> registers. For -malign-int, both kinds of structs are a problem.

Right, especially since those structure definitions are more
likely to be used on older drivers, there are probably some that
do happen on m68k. On the other hand, any driver that is portable
to non-m68k targets won't have this problem.

I tried a trivial m68k defconfig build with "-Wpadded -malign-int"
and found 3021 instances of structure padding, compared to 2271
without -malign-int. That is still something one could very reasonably
go through with 'vim -q output', as almost all of them are obviously
kernel-internal structures and not problematic.

A quick manual scan only shows a number of uapi structures but very
few drivers. There are a few hardware structures that are internally
packed but in a structure that has gets an extra two bytes of harmless
padding at the end (struct CUSTOM, struct amiga_hw_present,
struct atari_hw_present, struct TT_DMA, struct ppc_regs). The only
ones I could find that actually seemed suspicious are:

arch/m68k/include/asm/atarihw.h:426:10: warning: padding struct to align 'dst_address' [-Wpadded]
arch/m68k/include/asm/openprom.h:76:13: warning: padding struct to align 'boot_dev_ctrl' [-Wpadded]
drivers/net/ethernet/i825xx/82596.c:250:1: warning: padding struct size to alignment boundary

I'm sure there are a few more, but probably not a lot more.
See https://pastebin.com/Z2bjnD0G for the full list. I've also
tried annotating the ones that show up in defconfig, see diffstat
below.

Unfortunately I found no way of annotating a struct a whole to use
the traditional padding rules: "#pragma pack(push, 2)" lowers the
alignment of all struct members to two bytes, including those
with an explicit alignment like __aligned_u64. A struct-wide
__attribute__((packed, aligned(2))) seems even worse, as it
makes all members inside of the struck tightly packed and only
aligns the struct itself.

This means all misaligned members have to be individually marked
as __packed, unless someone comes up with another type of
annotation.

> If better performance is to be had, my guess is that aligning atomic_t 
> will get 80% of it (just an appeal to the Pareto principle, FWIW...)

arch/m68k selects CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS for anything
other than Dragonball, so I would not expect much performance difference
at all, unless CASL on unaligned data ends up causing alignment traps
as it does on most architectures.

     Arnd

 arch/m68k/atari/atakeyb.c                          |  2 +-
 arch/m68k/include/asm/amigahw.h                    |  4 +--
 arch/m68k/include/asm/atarihw.h                    |  6 ++--
 arch/m68k/include/asm/mvme147hw.h                  |  2 +-
 arch/m68k/include/asm/openprom.h                   |  2 +-
 arch/m68k/include/uapi/asm/ptrace.h                |  2 +-
 arch/m68k/include/uapi/asm/sigcontext.h            |  2 +-
 arch/m68k/include/uapi/asm/stat.h                  |  4 +--
 drivers/net/ethernet/i825xx/82596.c                |  4 +--
 include/uapi/asm-generic/termios.h                 |  2 +-
 include/uapi/linux/acct.h                          |  2 +-
 include/uapi/linux/ax25.h                          |  6 ++--
 include/uapi/linux/blktrace_api.h                  |  2 +-
 include/uapi/linux/btrfs.h                         |  2 +-
 include/uapi/linux/cdrom.h                         | 36 +++++++++++-----------
 include/uapi/linux/dlm.h                           |  2 +-
 include/uapi/linux/dqblk_xfs.h                     |  2 +-
 include/uapi/linux/ethtool.h                       | 14 ++++-----
 include/uapi/linux/fb.h                            |  6 ++--
 include/uapi/linux/fd.h                            |  6 ++--
 include/uapi/linux/filter.h                        |  2 +-
 include/uapi/linux/hdlc/ioctl.h                    |  6 ++--
 include/uapi/linux/hiddev.h                        |  2 +-
 include/uapi/linux/i2c-dev.h                       |  2 +-
 include/uapi/linux/i2c.h                           |  2 +-
 include/uapi/linux/if.h                            |  2 +-
 include/uapi/linux/if_arcnet.h                     |  4 +--
 include/uapi/linux/if_bonding.h                    |  2 +-
 include/uapi/linux/if_bridge.h                     | 14 ++++-----
 include/uapi/linux/if_link.h                       |  2 +-
 include/uapi/linux/if_plip.h                       |  2 +-
 include/uapi/linux/if_pppox.h                      |  2 +-
 include/uapi/linux/if_vlan.h                       |  2 +-
 include/uapi/linux/inet_diag.h                     |  2 +-
 include/uapi/linux/input.h                         |  4 +--
 include/uapi/linux/ip6_tunnel.h                    |  4 +--
 include/uapi/linux/kd.h                            |  2 +-
 include/uapi/linux/llc.h                           |  2 +-
 include/uapi/linux/loop.h                          |  2 +-
 include/uapi/linux/mctp.h                          |  4 +--
 include/uapi/linux/mptcp.h                         |  2 +-
 include/uapi/linux/mroute.h                        |  4 +--
 include/uapi/linux/mroute6.h                       |  6 ++--
 include/uapi/linux/msdos_fs.h                      |  2 +-
 include/uapi/linux/msg.h                           |  6 ++--
 include/uapi/linux/mtio.h                          |  2 +-
 include/uapi/linux/netfilter/ipset/ip_set.h        |  4 +--
 include/uapi/linux/netfilter/nf_nat.h              |  2 +-
 include/uapi/linux/netfilter/x_tables.h            |  8 ++---
 include/uapi/linux/netfilter/xt_HMARK.h            |  2 +-
 include/uapi/linux/netfilter/xt_TPROXY.h           |  4 +--
 include/uapi/linux/netfilter/xt_connbytes.h        |  2 +-
 include/uapi/linux/netfilter/xt_connmark.h         |  6 ++--
 include/uapi/linux/netfilter/xt_conntrack.h        |  4 +--
 include/uapi/linux/netfilter/xt_esp.h              |  2 +-
 include/uapi/linux/netfilter/xt_hashlimit.h        |  6 ++--
 include/uapi/linux/netfilter/xt_helper.h           |  2 +-
 include/uapi/linux/netfilter/xt_ipcomp.h           |  2 +-
 include/uapi/linux/netfilter/xt_iprange.h          |  2 +-
 include/uapi/linux/netfilter/xt_l2tp.h             |  2 +-
 include/uapi/linux/netfilter/xt_mac.h              |  2 +-
 include/uapi/linux/netfilter/xt_mark.h             |  2 +-
 include/uapi/linux/netfilter/xt_owner.h            |  2 +-
 include/uapi/linux/netfilter/xt_realm.h            |  2 +-
 include/uapi/linux/netfilter/xt_recent.h           |  4 +--
 include/uapi/linux/netfilter/xt_set.h              |  4 +--
 include/uapi/linux/netfilter/xt_statistic.h        |  2 +-
 include/uapi/linux/netfilter/xt_tcpmss.h           |  2 +-
 include/uapi/linux/netfilter/xt_tcpudp.h           |  2 +-
 include/uapi/linux/netfilter/xt_time.h             |  2 +-
 include/uapi/linux/netfilter/xt_u32.h              |  6 ++--
 include/uapi/linux/netfilter_arp/arp_tables.h      |  2 +-
 include/uapi/linux/netfilter_arp/arpt_mangle.h     |  2 +-
 include/uapi/linux/netfilter_bridge/ebt_802_3.h    |  2 +-
 include/uapi/linux/netfilter_bridge/ebt_arp.h      |  2 +-
 include/uapi/linux/netfilter_bridge/ebt_arpreply.h |  2 +-
 include/uapi/linux/netfilter_bridge/ebt_mark_m.h   |  2 +-
 include/uapi/linux/netfilter_bridge/ebt_nat.h      |  2 +-
 include/uapi/linux/netfilter_bridge/ebt_stp.h      |  4 +--
 include/uapi/linux/netfilter_bridge/ebt_vlan.h     |  2 +-
 include/uapi/linux/netfilter_ipv4/ipt_ah.h         |  2 +-
 include/uapi/linux/netfilter_ipv6/ip6_tables.h     |  2 +-
 include/uapi/linux/netfilter_ipv6/ip6t_ah.h        |  2 +-
 include/uapi/linux/netfilter_ipv6/ip6t_frag.h      |  2 +-
 include/uapi/linux/netfilter_ipv6/ip6t_opts.h      |  2 +-
 include/uapi/linux/netfilter_ipv6/ip6t_rt.h        |  2 +-
 include/uapi/linux/netfilter_ipv6/ip6t_srh.h       |  2 +-
 include/uapi/linux/netrom.h                        |  2 +-
 include/uapi/linux/nfs_idmap.h                     |  2 +-
 include/uapi/linux/nfs_mount.h                     |  2 +-
 include/uapi/linux/pkt_cls.h                       |  2 +-
 include/uapi/linux/rds.h                           |  4 +--
 include/uapi/linux/rose.h                          |  8 ++---
 include/uapi/linux/route.h                         |  2 +-
 include/uapi/linux/rtc.h                           |  2 +-
 include/uapi/linux/sctp.h                          | 18 +++++------
 include/uapi/linux/sed-opal.h                      |  2 +-
 include/uapi/linux/sem.h                           |  2 +-
 include/uapi/linux/serial.h                        |  4 +--
 include/uapi/linux/soundcard.h                     |  8 ++---
 include/uapi/linux/taskstats.h                     |  2 +-
 include/uapi/linux/virtio_net.h                    |  4 +--
 include/uapi/linux/wireless.h                      |  4 +--
 include/uapi/linux/xfrm.h                          | 26 ++++++++--------
 include/uapi/mtd/mtd-abi.h                         |  2 +-
 include/uapi/rdma/hfi/hfi1_ioctl.h                 |  2 +-
 include/uapi/rdma/ib_user_ioctl_verbs.h            |  2 +-
 include/uapi/rdma/ib_user_mad.h                    |  2 +-
 109 files changed, 205 insertions(+), 204 deletions(-)

