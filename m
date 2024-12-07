Return-Path: <linux-arch+bounces-9299-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C5519E8047
	for <lists+linux-arch@lfdr.de>; Sat,  7 Dec 2024 15:31:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3853E18815D1
	for <lists+linux-arch@lfdr.de>; Sat,  7 Dec 2024 14:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB3181EEE9;
	Sat,  7 Dec 2024 14:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HtoKdNBC"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E39BECF;
	Sat,  7 Dec 2024 14:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733581882; cv=none; b=HGBxq+qnz3jKq5003Gp5YZbkquizPNQbfEOPdkyyYQbK4elNfQpwXbv97InO3Yl/qMdHbSWwVBSIjoLTi2VxKg155T2ZSlB4NhSVb2UeY+0/Y385gxxB0yHh8u4BAFyolxeLq2CoPukif3IaJHn58eeoal45hzRuhLVz7Qk4+TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733581882; c=relaxed/simple;
	bh=1mAjUB+6PJH8h/1ng8hsnNIMlSVB4dVM2YPQcc7rJJw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sHaZ7Gv8mYGXdl7L0hiIniKunsBUqIO1WOc1veivD9tgRrJbfvYFpAc9ZqYUmIYM2O/2iTIchkRhGuNpg8/32dI3ziac6a/GfPRKv3F3E4ptkvMamtb9RMoIo0GgV6CsmfmjOJBmZNw06tLM+e6mK1nMxfu81OhtH4uS0GJVuIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HtoKdNBC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03EF0C4CEDE;
	Sat,  7 Dec 2024 14:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733581882;
	bh=1mAjUB+6PJH8h/1ng8hsnNIMlSVB4dVM2YPQcc7rJJw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=HtoKdNBCkJ6e6V2O/x5PFJWYS8MeRGEDXeLvmOjllEoPXCb0Z4Srtnl8Dj8t3m493
	 Wsx8OimgaK5zhKFDNXXLNbsViGfvhGb+HRWMb4hIuJ0jrZCQ7ysWD2W3PchJTSBeAi
	 PtK6+vVovTnJ+H3L1NpdND9ayfARKluOwQlXh977Y4nm35YUfkLMZucZfW7jfG/Q1c
	 da7wnHYS9zb908j66Oq/i+nb9JUwvyxxb1k6x/n7Xc/BrqkMJdyLsNg83SXx63cNps
	 dyAOzwuxPevyMcMq1ccMLLwR/Bu0MyoWjmRlzZwsT7x8P8di3zxDdVbR5r38Bt99sI
	 614iu5cbnWYyg==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-53df80eeeedso3004478e87.2;
        Sat, 07 Dec 2024 06:31:21 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUqqH4MmrDirW9glHFJhV20sR3PlOVRKhEDqNXFMt8lSHQrRaBGHxQ3puMyNcqPD9ZtX4fMKZMiKBkTVlgV@vger.kernel.org, AJvYcCVFMUjFkMWFsWuLOtDg46LmUzUBkBwxjTE8HWjOEYjk2iEi8QIbZKNm4afpm4WGFdKeOpwJVgu8vahT@vger.kernel.org, AJvYcCXHXbz5M8FzE+I9o2UmQ3GnrKBkC+RRWSRYrQmTIneJeUu/M6Ln+13HiJKHo9vK69AtO1i1fGx4tQXFSPVN@vger.kernel.org
X-Gm-Message-State: AOJu0YwxKbytUhMDQ4eSsWgt0ZZ1u8wGM0YnO5UR2bMdEtbyygcxUMpO
	mMTMUFdDPY3aCYe9AFX23ogbY6ejf/cU2kBJM9Cz1r40sL3L6VWe9MvofkFumYXc+9AtH2L45Ky
	wSnjvyezkOMeeMpZG4Q0IpGlFqPQ=
X-Google-Smtp-Source: AGHT+IGSmS+BwO2Galy4n6wucHiFYW/1WDFvxa4nelNWt1mhlrfHVwE0ZLjhNLJtmP7z9zCv560ih25aExn+MOnlvYU=
X-Received: by 2002:a19:e041:0:b0:53e:2f9d:6a7b with SMTP id
 2adb3069b0e04-53e2f9d7c18mr1513099e87.10.1733581880655; Sat, 07 Dec 2024
 06:31:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1733404444.git.geert+renesas@glider.be> <2c4a75726a976d117055055b68a31c40dcab044e.1733404444.git.geert+renesas@glider.be>
 <b0e9c31f81a368375541d16dbc88783f614ede6d.camel@perches.com>
In-Reply-To: <b0e9c31f81a368375541d16dbc88783f614ede6d.camel@perches.com>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Sat, 7 Dec 2024 23:30:44 +0900
X-Gmail-Original-Message-ID: <CAK7LNARwQq-woUeM+a-Eg=Kh3Eu045xL9Y6tbOY0FAM4+Jk4hQ@mail.gmail.com>
Message-ID: <CAK7LNARwQq-woUeM+a-Eg=Kh3Eu045xL9Y6tbOY0FAM4+Jk4hQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] checkpatch: Update reference to include/asm-<arch>
To: Joe Perches <joe@perches.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Oleg Nesterov <oleg@redhat.com>, 
	Arnd Bergmann <arnd@arndb.de>, Yury Norov <yury.norov@gmail.com>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Andy Whitcroft <apw@canonical.com>, 
	Dwaipayan Ray <dwaipayanray1@gmail.com>, Lukas Bulwahn <lukas.bulwahn@gmail.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, linux-arch@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 6, 2024 at 1:40=E2=80=AFAM Joe Perches <joe@perches.com> wrote:
>
> On Thu, 2024-12-05 at 14:20 +0100, Geert Uytterhoeven wrote:
> > "include/asm-<arch>" was replaced by "arch/<arch>/include/asm" a long
> > time ago.
>
> Thanks.


Is this check still needed?

include/asm was a symlink to include/asm-<architecture> in the old days,
but it no longer exists.

In which case, is this check triggered?




--=20
Best Regards
Masahiro Yamada

