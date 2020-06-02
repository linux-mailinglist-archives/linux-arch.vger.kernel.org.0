Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 350411EB37A
	for <lists+linux-arch@lfdr.de>; Tue,  2 Jun 2020 04:48:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726083AbgFBCsN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 1 Jun 2020 22:48:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725826AbgFBCsN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 1 Jun 2020 22:48:13 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34CD0C061A0E;
        Mon,  1 Jun 2020 19:48:12 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id d10so4404654pgn.4;
        Mon, 01 Jun 2020 19:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=tXLfb8REYstQRtUYyN/YAll9QOXoM7PZgW3xD5sxjrI=;
        b=rLOrD2RHIa/F7ZMBJweppXnO7dugX2a+2XftHYtJaFnfBNxmTBoNMLUL7ahHdqnfaK
         NoTM7tWTI8TkNiVRCzurJSSZ985pb+EvY4A9FzVOlRoJ95BgnpoEa1Y7NzVzA4kDa2vB
         IC6Yb79NV/QQBxLo8aBGZtPiT58M5NCKcsgNpt6Bc3yiKrUjc5jCJF/xsxAxWtVlqqMh
         I2jmlZ97i+9+bOOc9VgK/qooBYy3iKq/oypTN01NhwXi4b+UZOPjbeq5TMySQLTDRFYp
         QID97Y2eEN2zUE2HnTXXtu5wyMxlaBDbbTm//F7ETTAwmFd8t1FphYAci4CNTAGdYoHP
         tM8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=tXLfb8REYstQRtUYyN/YAll9QOXoM7PZgW3xD5sxjrI=;
        b=gFTaeb/3oizIuXVNK55mPhwrpkRMeEvk7ZCQaFNnfEzXB19nrIqP4HULqkN5U8jS/C
         FMs9uuKA+vNG8e5xJVHixk/hVvdBZVplrff9foeoJ7U87LOD5v/nsSehDLmflOZcPNG6
         tBwOvZkkxupQohNCepB8mlGjXdp3+NxkslSHNlFYJkGo3q2qafZ511yOdho+KioNzkPN
         0Wbw++CkbXqGIqNwCcRuHBevNJr4u0K5VjTJyHDy1nd81z044APgcpqnbEoncWmkZoso
         GpEAbh0qfbZ7jbZdAgKYtHJNhBkKyUOAb89EeqzjbmlZIHfHVxrsRsOefBmhMzh9UKeD
         H9ZQ==
X-Gm-Message-State: AOAM533pbY3nSH2LVyF0Y2qeB2/8QWr9Bp3U8K3qZvDokEAsynoTMJpE
        sYTy1LPhdpIaD474IkWX51g+EK9d0dY=
X-Google-Smtp-Source: ABdhPJz9tbIORI2xekpkOdbrkc//J9XWNHxoeaMDAvup7qt7AZ0lq5HldfTLFBv34uzKSpqmY6gC2A==
X-Received: by 2002:a62:6846:: with SMTP id d67mr23969488pfc.167.1591066091708;
        Mon, 01 Jun 2020 19:48:11 -0700 (PDT)
Received: from localhost ([108.161.26.224])
        by smtp.gmail.com with ESMTPSA id x9sm648723pfi.13.2020.06.01.19.48.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2020 19:48:10 -0700 (PDT)
Date:   Mon, 1 Jun 2020 19:48:04 -0700
From:   Matt Turner <mattst88@gmail.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-alpha@vger.kernel.org
Subject: Regression bisected to f2f84b05e02b (bug: consolidate
 warn_slowpath_fmt() usage)
Message-ID: <20200602024804.GA3776630@p50-ethernet.mattst88.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="NzB8fVQJ5HfG6fxh"
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--NzB8fVQJ5HfG6fxh
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I bisected a regression on alpha to f2f84b05e02b (bug: consolidate
warn_slowpath_fmt() usage) which looks totally innocuous.

Reverting it on master confirms that it somehow is the trigger. At or a
little after starting userspace, I'll see an oops like this:

Unable to handle kernel paging request at virtual address 0000000000000000
CPU 0
kworker/u2:5(98): Oops -1
pc =3D [<0000000000000000>]  ra =3D [<0000000000000000>]  ps =3D 0000    No=
t tainted
pc is at 0x0
ra is at 0x0
v0 =3D 0000000000000007  t0 =3D 0000000000000001  t1 =3D 0000000000000001
t2 =3D 0000000000000000  t3 =3D fffffc00bfe68780  t4 =3D 0000000000000001
t5 =3D fffffc00bf8cc780  t6 =3D 00000000026f8000  t7 =3D fffffc00bfe70000
s0 =3D fffffc000250d310  s1 =3D fffffc000250d310  s2 =3D fffffc000250d310
s3 =3D fffffc000250ca40  s4 =3D fffffc000250caa0  s5 =3D 0000000000000000
s6 =3D fffffc000250ca40
a0 =3D fffffc00024f0488  a1 =3D fffffc00bfe73d98  a2 =3D fffffc00bfe68800
a3 =3D fffffc00bf881400  a4 =3D 0001000000000000  a5 =3D 0000000000000002
t8 =3D 0000000000000000  t9 =3D 0000000000000000  t10=3D 0000000001321800
t11=3D 000000000000ba4e  pv =3D fffffc000189ca00  at =3D 0000000000000000
gp =3D fffffc000253e430  sp =3D 0000000043a83c2e
Disabling lock debugging due to kernel taint
Trace:
[<fffffc000105c8ac>] process_one_work+0x25c/0x5a0
[<fffffc000105cc4c>] worker_thread+0x5c/0x7d0
[<fffffc0001066c88>] kthread+0x188/0x1f0
[<fffffc0001011b48>] ret_from_kernel_thread+0x18/0x20
[<fffffc0001066b00>] kthread+0x0/0x1f0
[<fffffc000105cbf0>] worker_thread+0x0/0x7d0

Code:
  00000000
  00000000
  00063301
  000012e2
  00001111
  0005ffde

It seems to cause a hard lock on an SMP system, but not on a system with
a single CPU. Similarly, if I boot the SMP system (2 CPUs) with
maxcpus=3D1 the oops doesn't happen. Until I tested on a non-SMP system
today I suspected that it was unaffected, but I saw the oops there too.
With the revert applied, I don't see a warning or an oops.

Any clues how this patch could have triggered the oops?

Here's the revert, with a trivial conflict resolved, that I've used in
testing:

 From fdbdd0f606f0f412ee06c1152e33a22ca17102bc Mon Sep 17 00:00:00 2001
=46rom: Matt Turner <mattst88@gmail.com>
Date: Sun, 24 May 2020 20:46:00 -0700
Subject: [PATCH] Revert "bug: consolidate warn_slowpath_fmt() usage"

This reverts commit f2f84b05e02b7710a201f0017b3272ad7ef703d1.
---
  include/asm-generic/bug.h |  3 ++-
  kernel/panic.c            | 15 +++++++--------
  2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/include/asm-generic/bug.h b/include/asm-generic/bug.h
index 384b5c835ced..a4a311d4b4b0 100644
--- a/include/asm-generic/bug.h
+++ b/include/asm-generic/bug.h
@@ -82,7 +82,8 @@ struct bug_entry {
  extern __printf(4, 5)
  void warn_slowpath_fmt(const char *file, const int line, unsigned taint,
  		       const char *fmt, ...);
-#define __WARN()		__WARN_printf(TAINT_WARN, NULL)
+extern void warn_slowpath_null(const char *file, const int line);
+#define __WARN()		warn_slowpath_null(__FILE__, __LINE__)
  #define __WARN_printf(taint, arg...)					\
  	warn_slowpath_fmt(__FILE__, __LINE__, taint, arg)
  #else
diff --git a/kernel/panic.c b/kernel/panic.c
index b69ee9e76cb2..c8ed8046b484 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -603,20 +603,19 @@ void warn_slowpath_fmt(const char *file, int line, un=
signed taint,
  {
  	struct warn_args args;
 =20
-	pr_warn(CUT_HERE);
-
-	if (!fmt) {
-		__warn(file, line, __builtin_return_address(0), taint,
-		       NULL, NULL);
-		return;
-	}
-
  	args.fmt =3D fmt;
  	va_start(args.args, fmt);
  	__warn(file, line, __builtin_return_address(0), taint, NULL, &args);
  	va_end(args.args);
  }
  EXPORT_SYMBOL(warn_slowpath_fmt);
+
+void warn_slowpath_null(const char *file, int line)
+{
+	pr_warn(CUT_HERE);
+	__warn(file, line, __builtin_return_address(0), TAINT_WARN, NULL, NULL);
+}
+EXPORT_SYMBOL(warn_slowpath_null);
  #else
  void __warn_printk(const char *fmt, ...)
  {
--=20
2.26.2

--NzB8fVQJ5HfG6fxh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iNUEABYKAH0WIQSzlptPDvl9ch5jjr2cglpmBdQLvgUCXtW94l8UgAAAAAAuAChp
c3N1ZXItZnByQG5vdGF0aW9ucy5vcGVucGdwLmZpZnRoaG9yc2VtYW4ubmV0QjM5
NjlCNEYwRUY5N0Q3MjFFNjM4RUJEOUM4MjVBNjYwNUQ0MEJCRQAKCRCcglpmBdQL
vhczAP9lpK9GDG2VnFlPAgh0FMvq3Z750UnH82UUiklN6xZkXwD+Mggvk1WV1XAW
7S99g69EMvaFojGmQu1H3oXK3IAslg0=
=8cBu
-----END PGP SIGNATURE-----

--NzB8fVQJ5HfG6fxh--
