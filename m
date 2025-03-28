Return-Path: <linux-arch+bounces-11180-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CD93A75293
	for <lists+linux-arch@lfdr.de>; Fri, 28 Mar 2025 23:53:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA2A33AD73A
	for <lists+linux-arch@lfdr.de>; Fri, 28 Mar 2025 22:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A01D1F180C;
	Fri, 28 Mar 2025 22:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ILMyTjyB"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAFB71E51E9;
	Fri, 28 Mar 2025 22:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743202384; cv=none; b=X60ObQj/m/Ay8EtV5fJmOGINK1avj/drrvjw+glWJ2T8cqUjfJiaAYNf10fRlRE4mQ+r9OgKqKlaZckea5qrScfQbHh3FVEMOXdXQSIKOikj/lFMR5A+vBQcnZmbyLht4+qXlXZxDRYgXSN7oyYrfFWv+/2B+CiTubFgZDEtBfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743202384; c=relaxed/simple;
	bh=uMHCMkIp1JpzwK/KslzBXCnJB3B/qFWTnmOMAK1in40=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=nStyfaehMKmRA/FYjTNvvt7nJJbJXwaMDzwAG2H3sVuHsa3TnU6ftsB428Wvn3vABBkFzIu4LBKf9J9M0COnuqOmIxMtbjLPBXQ5SiildSwZpaLur/swBTGFIk4OWxTAtCWjDzHBex8QLEAQydWnW3fwkYZHOvXAKcBpjrIwRYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ILMyTjyB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 353EEC4CEE4;
	Fri, 28 Mar 2025 22:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1743202383;
	bh=uMHCMkIp1JpzwK/KslzBXCnJB3B/qFWTnmOMAK1in40=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ILMyTjyBso7K5+o4nbs26Pn5cHVWQm2GLLUBUU6L6Xi+fwqx2KCM3V3LBajgA8puB
	 KnrvP/bQN8GP5OomQ+aEM6tjBdfck+qoFXs8ztHAbcsuc/oeySEGgq4ad2PiOAdMnP
	 tYCiaYsel0JulQkbsLDNglaz+OTqx9udrazM6AgY=
Date: Fri, 28 Mar 2025 15:53:01 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Guenter Roeck <linux@roeck-us.net>, Brendan Higgins
 <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, Rae Moar
 <rmoar@google.com>, Maxime Ripard <mripard@kernel.org>, Kees Cook
 <kees@kernel.org>, Alessandro Carminati <acarmina@redhat.com>,
 linux-kselftest@vger.kernel.org, David Airlie <airlied@gmail.com>, Arnd
 Bergmann <arnd@arndb.de>, =?ISO-8859-1?Q?Ma=EDra?= Canal
 <mcanal@igalia.com>, Dan Carpenter <dan.carpenter@linaro.org>, Daniel Diaz
 <daniel.diaz@linaro.org>, Arthur Grillo <arthurgrillo@riseup.net>, Naresh
 Kamboju <naresh.kamboju@linaro.org>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Ville =?ISO-8859-1?Q?Syrj=E4l=E4?=
 <ville.syrjala@linux.intel.com>, Daniel Vetter <daniel@ffwll.ch>, Thomas
 Zimmermann <tzimmermann@suse.de>, Alessandro Carminati
 <alessandro.carminati@gmail.com>, Jani Nikula <jani.nikula@intel.com>,
 dri-devel@lists.freedesktop.org, kunit-dev@googlegroups.com,
 linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-sh@vger.kernel.org, loongarch@lists.linux.dev, x86@kernel.org
Subject: Re: [PATCH v4 00/14] Add support for suppressing warning backtraces
Message-Id: <20250328155301.ab5514e2ab8043512a8527bd@linux-foundation.org>
In-Reply-To: <a998f3fa-495c-4165-884a-a11c5cb61e96@linuxfoundation.org>
References: <20250313114329.284104-1-acarmina@redhat.com>
	<202503131016.5DCEAEC945@keescook>
	<20250313-abiding-vivid-robin-159dfa@houat>
	<c8287bde-fa1c-4113-af22-4701d40d386e@roeck-us.net>
	<20250313150505.cf1568bf7197a52a8ab302e6@linux-foundation.org>
	<a998f3fa-495c-4165-884a-a11c5cb61e96@linuxfoundation.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 28 Mar 2025 16:14:55 -0600 Shuah Khan <skhan@linuxfoundation.org> wrote:

> On 3/13/25 16:05, Andrew Morton wrote:
> > On Thu, 13 Mar 2025 11:31:12 -0700 Guenter Roeck <linux@roeck-us.net> wrote:
> > 
> >> On Thu, Mar 13, 2025 at 06:24:25PM +0100, Maxime Ripard wrote:
> >>>>
> >>>> Yeah, as with my prior review, I'm a fan of this. It makes a bunch of my
> >>>> very noisy tests much easier to deal with.
> >>>
> >>> And for the record, we're also affected by this in DRM and would very
> >>> much like to get it merged in one shape or another.
> >>>
> >>
> >> I was unable to get maintainers of major architectures interested enough
> >> to provide feedback, and did not see a path forward. Maybe Alessandro
> >> has more success than me.
> > 
> > I'll put them into mm.git, to advance things a bit.
> 
> I haven't heard from kunit maintainers yet. This thread got lost
> in inbox due to travel.
> 
> David/Brendan/Rae, Okay to take this series?
> 
>
> Andrew, Okay to take this through your tree - this needs merging.


The review for 07/14 made me expect an update - perhaps tweak the asm
constraints and add a comment.  This can be addressed later, as long as
we don't forget.

However
https://lkml.kernel.org/r/20250324104702.12139E73-hca@linux.ibm.com
needs to be addressed before a merge.  The series in mm.git breaks the
s390 build.



