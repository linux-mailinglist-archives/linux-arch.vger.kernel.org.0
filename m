Return-Path: <linux-arch+bounces-12968-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 063B0B12B66
	for <lists+linux-arch@lfdr.de>; Sat, 26 Jul 2025 18:22:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F16E91C208C3
	for <lists+linux-arch@lfdr.de>; Sat, 26 Jul 2025 16:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA23F19D09C;
	Sat, 26 Jul 2025 16:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="VU2D/5Rh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ahz/cdtk"
X-Original-To: linux-arch@vger.kernel.org
Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553F12309B0;
	Sat, 26 Jul 2025 16:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753546973; cv=none; b=S8fm7k+j6DhHqSQGpqKCyG2UoDLg8oAhZXif68minbj/jFkqtqy2ceZvI3QYlrfDUpmA0KM6lbAoLwAXPDbnBtkWu+Yz3hNeLA39IO4uNhVXkpTrcGqP2b4IfKFoteUH1/a4eZ93bz1kl2PPm2foCKF/GCog5/k6FoSI+++/mu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753546973; c=relaxed/simple;
	bh=4sCizot5SpBYAlWqEyK4rvqM6D+CGQd8XeXFI/ctnlE=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=ZW+Zom8harwtbxqfZiDxjOaOlgZX/qQycw4CkBRHLhrrykdLTjn4FHRuMHMbvDfsgYH/FWePfUPwWfo7ZYUYtyeihyWlS+eHZY0xBAN5GBQnAEbLJf8CEkL8QokhRrTjPfMqG2MTZpCJXByEVRE1lLx2QZnANzSuMGb37FWRQTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=VU2D/5Rh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ahz/cdtk; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3C86E7A0460;
	Sat, 26 Jul 2025 12:22:49 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Sat, 26 Jul 2025 12:22:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1753546969;
	 x=1753633369; bh=cmAER4b+98v/6KB9uDhqP6D0jz83ezLrqrs4+cYx2R8=; b=
	VU2D/5Rhkdtw1YJ/zsuZlIHfTemjvtOnsh866m1HrzVH1gQNBhICp8wxqv7h4tkL
	WS98b4iJVqS78FNjEWHQAp7jfp8dI294rsJrrhy9T6+RwCOtsDbdCRy5kEKMlq+0
	H9GC98SkreEnlYpVP4GEKzHHhv7TUtW4DmQBn4wM7OC0ZwklpcYfCO3Wg6DsqvRE
	90l58kiLzK3gLw4JPiYjOHMod5G3Fy8b6XYUk5+8NYM1UsLxjhYgZDNF5U0GIuq0
	vrVukxngGsefWL36Lx8I8ID9l2/4L/g/2y4VMwMSKYw7mV6kOQ+kDLp3/dHzCbeF
	cT+vSddK84BwG3BVzH727Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1753546969; x=
	1753633369; bh=cmAER4b+98v/6KB9uDhqP6D0jz83ezLrqrs4+cYx2R8=; b=a
	hz/cdtkF3+1242uyZzW/0+ZbupjGQdutBJN3PotoC7MDppv7zKVS82Ysl4XJfQF/
	d6ujW+sY+gXSFFgLJc6moXHF82OHrMsjUchRE4yhxRMGnglstzDGE1IK4RLWrfM7
	H5zMVweslEc+DRsC9CsVD3IAdc2XPU+M7etfbHJVcJeNzi6ht5XQhrWwe6tem1NR
	UNhz3qsyqAMt7Qe7aQGDnxX3OoO7bFSRdQgpnNd6H3sCaGJp4n9WR5k1vRoQdXKb
	MR4bZ0QwLq6I+TYcx72m/6VzdpW0Am0cmSe21UnYRSC1crLby0vtEuutXiJD8BGd
	JdnPiYHJ96RnMEQrRbEYQ==
X-ME-Sender: <xms:2ACFaHkPM7P2lqKxbd0MnP0NR3rIqS2OUepz-gu5au8kbMbJmBTWYw>
    <xme:2ACFaK1oJqYrXys1-4p8j0LD2JTouX5YSqOl2rcbQWTOzxGVsqFT3FSfTD_OCeJKm
    az5rsO6q59pH2feAqY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdekieekkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdetrhhnugcu
    uegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrh
    hnpedvhfdvkeeuudevfffftefgvdevfedvleehvddvgeejvdefhedtgeegveehfeeljeen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnug
    esrghrnhgusgdruggvpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdp
    rhgtphhtthhopehvrghrrggughgruhhtrghmsehgohhoghhlvgdrtghomhdprhgtphhtth
    hopehquhhitggpshgrihhprhgrkhgrsehquhhitghinhgtrdgtohhmpdhrtghpthhtohep
    lhhinhhugidqrghrtghhsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplh
    hinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    shhtrggslhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:2ACFaECrV7P-BIuQ_mtpUniuRmz_9dXdTPWbty0fjp13KWGbv89vnQ>
    <xmx:2ACFaO_E8sdb30tTn-HdJwCg7s6n_C7wpi-AajcdD75OMGHiT4eTgg>
    <xmx:2ACFaIADjvG0W6En6ShYJ-6mKGgifrIJTPsjkkliBEURkKozGWDAbA>
    <xmx:2ACFaLRMEhENVgDxMMn6JeGXm4Z32VmoIWLyBMXuACREYX-d0ZZeWQ>
    <xmx:2QCFaAWBkI2Z9l-9juhE-dyMQLJRzac8CP1yDc7zeIqJ-nhn6p9jdY1N>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id B7B08700065; Sat, 26 Jul 2025 12:22:48 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Tb16c300fb1523219
Date: Sat, 26 Jul 2025 18:22:27 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Varad Gautam" <varadgautam@google.com>,
 Linux-Arch <linux-arch@vger.kernel.org>
Cc: "Sai Prakash Ranjan" <quic_saipraka@quicinc.com>,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Message-Id: <f74d9899-6aba-4c8e-87b1-cd6ecc7772e6@app.fastmail.com>
In-Reply-To: 
 <CAOLDJOJ98EccMJ4O3FyX4mSFtHnbQ4iwwXsHT2EbLL+KrXfvtw@mail.gmail.com>
References: <20250330164229.2174672-1-varadgautam@google.com>
 <CAOLDJO+=+hcz498KRc+95dF5y3hZdtm+3y35o2rBC9qAOF-vDg@mail.gmail.com>
 <CAOLDJOKiEmde5Max0BnTBVpNmfpm-wwYLJ4Etv8D2KZKPHyFzw@mail.gmail.com>
 <CAOLDJOJ=QcQ065UTAdGayO2kbpGMOwCtdEGVm8TvQO8Wf8CSMw@mail.gmail.com>
 <CAOLDJOJ98EccMJ4O3FyX4mSFtHnbQ4iwwXsHT2EbLL+KrXfvtw@mail.gmail.com>
Subject: Re: [PATCH] asm-generic/io.h: Skip trace helpers if rwmmio events are disabled
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 24, 2025, at 13:49, Varad Gautam wrote:
> On Wed, May 28, 2025 at 5:28=E2=80=AFPM Varad Gautam <varadgautam@goog=
le.com> wrote:
>>
>> On Mon, Apr 28, 2025 at 9:41=E2=80=AFPM Varad Gautam <varadgautam@goo=
gle.com> wrote:
>> >
>> > On Mon, Apr 7, 2025 at 6:13=E2=80=AFPM Varad Gautam <varadgautam@go=
ogle.com> wrote:
>> > >
>> > > On Sun, Mar 30, 2025 at 6:42=E2=80=AFPM Varad Gautam <varadgautam=
@google.com> wrote:
>> > > >
>> > > > With `CONFIG_TRACE_MMIO_ACCESS=3Dy`, the `{read,write}{b,w,l,q}=
{_relaxed}()`
>> > > > mmio accessors unconditionally call `log_{post_}{read,write}_mm=
io()`
>> > > > helpers, which in turn call the ftrace ops for `rwmmio` trace e=
vents
>> > > >
>> > > > This adds a performance penalty per mmio accessor call, even wh=
en
>> > > > `rwmmio` events are disabled at runtime (~80% overhead on local
>> > > > measurement).
>> > > >
>> > > > Guard these with `tracepoint_enabled()`.
>> > > >
>> > > > Signed-off-by: Varad Gautam <varadgautam@google.com>
>> > > > Fixes: 210031971cdd ("asm-generic/io: Add logging support for M=
MIO accessors")
>> > > > Cc: <stable@vger.kernel.org>
>> > >
>> > > Ping.
>> > >
>> >
>> > Ping.
>> >
>>
>> Ping. Arnd, can this be picked up into the asm-generic tree?
>>
>
> Ping.

I'm sorry I keep missing this one. It's really too late again for
the merge window, so it won't be in 6.17 either, but I've applied
it locally in my asm-generic branch that I'm planning for 6.18
so I hope I won't miss it again.

I currently have nothing queued up for 6.17 at all, but I already
have some of my own patches that I plan to submit for review after
the merge window and merge through the asm-generic tree.

     Arnd

