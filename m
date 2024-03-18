Return-Path: <linux-arch+bounces-3019-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EABA87E285
	for <lists+linux-arch@lfdr.de>; Mon, 18 Mar 2024 04:25:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E041280E89
	for <lists+linux-arch@lfdr.de>; Mon, 18 Mar 2024 03:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDA091E894;
	Mon, 18 Mar 2024 03:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="aZwR6Ce1"
X-Original-To: linux-arch@vger.kernel.org
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6A01E86A;
	Mon, 18 Mar 2024 03:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710732311; cv=none; b=bVnLtilTpvxblq3GqKOOQCY1jMff3LNbrlXXEqytJ63xkGzDPeRFdWgQCznu1G/vDh0BVUEM2pbGeLKdOVdvLLgc1z2VnoraEwOX8XpGnkK3VoU/K9+BYbDKYf4gRhSyw3JKEStzKi9qVjMuWbVeCHqPEuEjU8qxqkVcl1/37t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710732311; c=relaxed/simple;
	bh=NV+IEiKEp7lCdjzjbneFkp6G29/AFeVDyz/GqmHX3m4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qI9I8/C6jvBvgSNuCCFvnjTqzeoFisRHqtE3qI9yvJaq+bb9OBGWx/yWfy95GlIINluKUU0ORg9rRQPsS//T9CGnBX7SRqWHI+cE8l0dQBnISAYkJQmE8ckRG8rqFgRFENJzD+8w/hC7e8ec2LSh5cj7ssB8mqmDCiAbeKq/Jw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=aZwR6Ce1; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1710732306;
	bh=NV+IEiKEp7lCdjzjbneFkp6G29/AFeVDyz/GqmHX3m4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=aZwR6Ce11vNXim4mOCh1eXkx7K65RfM+cau+BhgB9SdLqlZPW+NSBiMfH6HvhOd0A
	 Cxq4iA45zUMfJd0t0fiCZUW9oT7MdElC1lAHDwjgYhkFVet+3SexBY3VTuWZ+t2GS/
	 R6YtLN+mqg6XUSgVsgcCPTEOKRlHDfSmPt/ef1FfXW6waLfQPAdiG7JMm/zsq5BT3k
	 vdQUUXBAz8sJiI6L7YfwQCfB8GuYQWxC3Reysu8xNTnmju7VZ+DNwIB5BF60uJsyDk
	 OdmHw4LQNlhzuekWxZGLa0lNLJlIa+tl6Z4Z3Fg6YFxfGk0yqItTN1sXJzV54NgtGp
	 w8QwwUGGGIyQQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TygG42yLDz4wc1;
	Mon, 18 Mar 2024 14:25:00 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Guenter Roeck <linux@roeck-us.net>, Geert Uytterhoeven
 <geert@linux-m68k.org>
Cc: linux-kselftest@vger.kernel.org, David Airlie <airlied@gmail.com>, Arnd
 Bergmann <arnd@arndb.de>, =?utf-8?Q?Ma=C3=ADra?= Canal <mcanal@igalia.com>,
 Dan Carpenter
 <dan.carpenter@linaro.org>, Kees Cook <keescook@chromium.org>, Daniel Diaz
 <daniel.diaz@linaro.org>, David Gow <davidgow@google.com>, Arthur Grillo
 <arthurgrillo@riseup.net>, Brendan Higgins <brendan.higgins@linux.dev>,
 Naresh Kamboju <naresh.kamboju@linaro.org>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Andrew Morton
 <akpm@linux-foundation.org>, Maxime Ripard <mripard@kernel.org>, Ville
 =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>, Daniel Vetter
 <daniel@ffwll.ch>,
 Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org,
 kunit-dev@googlegroups.com, linux-arch@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
 loongarch@lists.linux.dev, netdev@lists.linux.dev
Subject: Re: [PATCH 00/14] Add support for suppressing warning backtraces
In-Reply-To: <04f34097-7788-490d-a9c2-82b44bf6af44@roeck-us.net>
References: <20240312170309.2546362-1-linux@roeck-us.net>
 <CAMuHMdUkvagJVEfnhq=Nx2jnmdS0Ax+zy1CvyN0k7k1EwUpu+g@mail.gmail.com>
 <6d9269c0-bd38-4965-a454-4358e0a182e3@roeck-us.net>
 <04f34097-7788-490d-a9c2-82b44bf6af44@roeck-us.net>
Date: Mon, 18 Mar 2024 14:24:59 +1100
Message-ID: <87ttl4z0fo.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Guenter Roeck <linux@roeck-us.net> writes:
> On 3/14/24 07:37, Guenter Roeck wrote:
>> On 3/14/24 06:36, Geert Uytterhoeven wrote:
>>> Hi G=C3=BCnter,
>>>
>>> On Tue, Mar 12, 2024 at 6:03=E2=80=AFPM Guenter Roeck <linux@roeck-us.n=
et> wrote:
>>>> Some unit tests intentionally trigger warning backtraces by passing bad
>>>> parameters to kernel API functions. Such unit tests typically check the
>>>> return value from such calls, not the existence of the warning backtra=
ce.
>>>>
>>>> Such intentionally generated warning backtraces are neither desirable
>>>> nor useful for a number of reasons.
>>>> - They can result in overlooked real problems.
>>>> - A warning that suddenly starts to show up in unit tests needs to be
>>>> =C2=A0=C2=A0 investigated and has to be marked to be ignored, for exam=
ple by
>>>> =C2=A0=C2=A0 adjusting filter scripts. Such filters are ad-hoc because=
 there is
>>>> =C2=A0=C2=A0 no real standard format for warnings. On top of that, suc=
h filter
>>>> =C2=A0=C2=A0 scripts would require constant maintenance.
>>>>
>>>> One option to address problem would be to add messages such as "expect=
ed
>>>> warning backtraces start / end here" to the kernel log.=C2=A0 However,=
 that
>>>> would again require filter scripts, it might result in missing real
>>>> problematic warning backtraces triggered while the test is running, and
>>>> the irrelevant backtrace(s) would still clog the kernel log.
>>>>
>>>> Solve the problem by providing a means to identify and suppress specif=
ic
>>>> warning backtraces while executing test code. Support suppressing mult=
iple
>>>> backtraces while at the same time limiting changes to generic code to =
the
>>>> absolute minimum. Architecture specific changes are kept at minimum by
>>>> retaining function names only if both CONFIG_DEBUG_BUGVERBOSE and
>>>> CONFIG_KUNIT are enabled.
>>>>
>>>> The first patch of the series introduces the necessary infrastructure.
>>>> The second patch introduces support for counting suppressed backtraces.
>>>> This capability is used in patch three to implement unit tests.
>>>> Patch four documents the new API.
>>>> The next two patches add support for suppressing backtraces in drm_rect
>>>> and dev_addr_lists unit tests. These patches are intended to serve as
>>>> examples for the use of the functionality introduced with this series.
>>>> The remaining patches implement the necessary changes for all
>>>> architectures with GENERIC_BUG support.
>>>
>>> Thanks for your series!
>>>
>>> I gave it a try on m68k, just running backtrace-suppression-test,
>>> and that seems to work fine.
>>>
>>>> Design note:
>>>> =C2=A0=C2=A0 Function pointers are only added to the __bug_table secti=
on if both
>>>> =C2=A0=C2=A0 CONFIG_KUNIT and CONFIG_DEBUG_BUGVERBOSE are enabled to a=
void image
>>>> =C2=A0=C2=A0 size increases if CONFIG_KUNIT=3Dn. There would be some b=
enefits to
>>>> =C2=A0=C2=A0 adding those pointers all the time (reduced complexity, a=
bility to
>>>> =C2=A0=C2=A0 display function names in BUG/WARNING messages). That cha=
nge, if
>>>> =C2=A0=C2=A0 desired, can be made later.
>>>
>>> Unfortunately this also increases kernel size in the CONFIG_KUNIT=3Dm
>>> case (ca. 80 KiB for atari_defconfig), making it less attractive to have
>>> kunit and all tests enabled as modules in my standard kernel.
>>>
>>=20
>> Good point. Indeed, it does. I wanted to avoid adding a configuration op=
tion,
>> but maybe I should add it after all. How about something like this ?
>>=20
>> +config KUNIT_SUPPRESS_BACKTRACE
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool "KUnit - Enable backtrace sup=
pression"
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 default y
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 help
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Enable backtrace suppr=
ession for KUnit. If enabled, backtraces
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 generated intentionall=
y by KUnit tests can be suppressed. Disable
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 to reduce kernel image=
 size if image size is more important than
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 suppression of backtra=
ces generated by KUnit tests.
>
> Any more comments / feedback on this ? Otherwise I'll introduce the
> above configuration option in v2 of the series.
>
> In this context, any suggestions if it should be enabled or disabled by
> default ? I personally think it would be more important to be able to
> suppress backtraces, but I understand that others may not be willing to
> accept a ~1% image size increase with CONFIG_KUNIT=3Dm unless
> KUNIT_SUPPRESS_BACKTRACE is explicitly disabled.

Please enable it by default.

There are multiple CI systems that will benefit from it, whereas the
number of users enabling KUNIT in severely spaced constrainted
environments is surely small - perhaps just Geert ;).

cheers

