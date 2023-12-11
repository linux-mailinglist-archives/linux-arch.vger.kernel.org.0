Return-Path: <linux-arch+bounces-903-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5945A80DE12
	for <lists+linux-arch@lfdr.de>; Mon, 11 Dec 2023 23:17:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E42DA1F21A63
	for <lists+linux-arch@lfdr.de>; Mon, 11 Dec 2023 22:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0A6855788;
	Mon, 11 Dec 2023 22:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EJGkd/iw"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1534F92
	for <linux-arch@vger.kernel.org>; Mon, 11 Dec 2023 14:16:50 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-40c3963f9fcso6285e9.1
        for <linux-arch@vger.kernel.org>; Mon, 11 Dec 2023 14:16:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702333008; x=1702937808; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nvF5V1Q9Ar02mtoysYDu05U7aSKEzXllew7q5EyIvRE=;
        b=EJGkd/iw2jT4LICCe7+1ZUUwN7mBfzeOtBXag0ZjSuy9YBg/LBxNWAFQQ7Il7oD0/W
         natwddcNSVEvix41/0w02yQvnstpeVWLmZW6nHMcMTCn407rnT7CZV5jkkI+ouyYG/O2
         uAbBZOJlmBL2FhYDMN32/d3PHfZEuVZNkzWhfCti6QFl+1UpEUa+hAxo144ds8nGSZkD
         X8kVeWtJlLjj6Tuz3dfFEMu56+vgn31UFcAKVsJtIC0vkhg3ItzzyVSWW2hEJApzUJQy
         Qyq7JtKPNEg7ILjTzWPZObmhA3X5nGxSh4YHyk7wP3BYYZBi+E7KsrdxstPjOez//nmI
         yKHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702333008; x=1702937808;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nvF5V1Q9Ar02mtoysYDu05U7aSKEzXllew7q5EyIvRE=;
        b=MtGRensRzJv1+D11B2ozB+zQsz+SZaM0OlRELfF90KLKlu82o/b85PJRjbF52r0tdy
         AI+DCYj/7rmtulFxtm0EWDRP5j4iVAV0S+sHG2cMHszoypF77w5KpIivYVH+HQsTuCon
         NCw6U8vUgs4ZuwbhcTAAZWmsCvZAPJ12QvMfpmA3EnoGE10EbGQt7iQ+yjLp3MKu7vvh
         Y1WYveaRW9JKfcnUc5czhGU+p7bZvSj6kioo2EtGfGXHXcL/LaY24fL34OYOTunQap4k
         igp5bVkfhF7Kg+8DMe5LZZTUz572LQewjnFzeMtc1A0LE88lM4+4PgG9qS9sb4HkRHsg
         riFw==
X-Gm-Message-State: AOJu0YzyTSDv9Oo8dYsCmnv0TvDzgWHo/af1HZG3zhW2F7iUVEUCNZde
	kqpRSgwbuL6C5wmvl8oxZi++ZlvGVJeiby2FIjU7qw==
X-Google-Smtp-Source: AGHT+IFpb1D1ELfBB0XjKdpLdiG584OwfX3FeJOeBZ0Uir/keSyebeXbF0BprRN9LD/H+g2A9OXUfFP3Ggfu3iAe+mU=
X-Received: by 2002:a05:600c:1910:b0:40c:337e:f596 with SMTP id
 j16-20020a05600c191000b0040c337ef596mr258861wmq.0.1702333008321; Mon, 11 Dec
 2023 14:16:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231204221932.1465004-1-rmoar@google.com> <20231204221932.1465004-6-rmoar@google.com>
 <CABVgOS=JAn49ux6Cg2i1-V_2eNH4Utx_areqg4H1p5xwkT9FMA@mail.gmail.com>
In-Reply-To: <CABVgOS=JAn49ux6Cg2i1-V_2eNH4Utx_areqg4H1p5xwkT9FMA@mail.gmail.com>
From: Rae Moar <rmoar@google.com>
Date: Mon, 11 Dec 2023 17:16:36 -0500
Message-ID: <CA+GJov7fUjfKL=O2wC4ZKMvO8OMYJm07h0vGQRDxRF6v4EOpxg@mail.gmail.com>
Subject: Re: [PATCH v3 6/6] Documentation: Add debugfs docs with run after boot
To: David Gow <davidgow@google.com>
Cc: shuah@kernel.org, dlatypov@google.com, brendan.higgins@linux.dev, 
	sadiyakazi@google.com, keescook@chromium.org, arnd@arndb.de, 
	linux-kselftest@vger.kernel.org, linux-arch@vger.kernel.org, 
	kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 9, 2023 at 2:58=E2=80=AFAM David Gow <davidgow@google.com> wrot=
e:
>
> On Tue, 5 Dec 2023 at 06:19, Rae Moar <rmoar@google.com> wrote:
> >
> > Expand the documentation on the KUnit debugfs filesystem on the
> > run_manual.rst page.
> >
> > Add section describing how to access results using debugfs.
> >
> > Add section describing how to run tests after boot using debugfs.
> >
> > Signed-off-by: Rae Moar <rmoar@google.com>
> > ---
>
> Looks good to me, some nitpicks below.
>
> The other thing I'd really want to add is some documentation on
> writing init-section suites, which covers the pitfalls better (as
> mentioned in the previous emails). Though that could be a separate
> patch if you want to keep this one debugfs-specific.
>
> Otherwise,
> Reviewed-by: David Gow <davidgow@google.com>
>
> Cheers,
> -- David

Hello!

I have responded to your comments below. I would also be happy to add
documentation to the init-section suites either in this patch series
or in a future one.

Thanks!
-Rae

>
> >
> > Changes since v2:
> > - Add info to documentation about cleaning up data, init tests, and
> >   running tests concurrently
> >
> >  Documentation/dev-tools/kunit/run_manual.rst | 49 ++++++++++++++++++--
> >  1 file changed, 45 insertions(+), 4 deletions(-)
> >
> > diff --git a/Documentation/dev-tools/kunit/run_manual.rst b/Documentati=
on/dev-tools/kunit/run_manual.rst
> > index e7b46421f247..aebb52ba9605 100644
> > --- a/Documentation/dev-tools/kunit/run_manual.rst
> > +++ b/Documentation/dev-tools/kunit/run_manual.rst
> > @@ -49,9 +49,50 @@ loaded.
> >
> >  The results will appear in TAP format in ``dmesg``.
> >
> > +debugfs
> > +=3D=3D=3D=3D=3D=3D=3D
> > +
> > +``debugfs`` is a file system that enables user interaction with the fi=
les to
> > +make kernel information available to user space (See more information =
at
> > +Documentation/filesystems/debugfs.html)
>
> Nit: reference debugfs.rst here, not debugfs.html -- sphinx ought to
> update the link automatically.

Thanks for catching this! I didn't realize Sphinx would update it.

>
> Also, maybe we can make this introduction a _little_ bit more
> KUnit-specific. I'd personally start by saying that KUnit can be
> accessed from userspace via the debugfs filesystem (link), usually
> mounted in /sys/kernel/debug/kunit, etc, if CONFIG_KUNIT_DEBUGFS is
> enabled.

Ok I will add this for the next version.

>
> > +
> > +By default, only the root user has access to the debugfs directory.
> > +
> > +If ``CONFIG_KUNIT_DEBUGFS`` is enabled, you can use KUnit debugfs
> > +filesystem to perform the following actions.
> > +
> > +Retrieve Test Results
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +You can use debugfs to retrieve KUnit test results. The test results a=
re
> > +accessible from the debugfs filesystem in the following read-only file=
:
> > +
> > +.. code-block :: bash
> > +
> > +       /sys/kernel/debug/kunit/<test_suite>/results
> > +
> > +The test results are available in KTAP format.
>
> Do we want to note that this is a separate KTAP document, and so may
> have different suite numbering from the dmesg log?

Sure! I will add this for the next version.

>
> > +
> > +Run Tests After Kernel Has Booted
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +You can use the debugfs filesystem to trigger built-in tests to run af=
ter
> > +boot. To run the test suite, you can use the following command to writ=
e to
> > +the ``/sys/kernel/debug/kunit/<test_suite>/run`` file:
> > +
> > +.. code-block :: bash
> > +
> > +       echo "any string" > /sys/kernel/debugfs/kunit/<test_suite>/run
> > +
> > +As a result, the test suite runs and the results are printed to the ke=
rnel
> > +log.
> > +
> > +However, this feature is not available with KUnit tests that use init =
data.
>
> Let's expand this slightly, and mention that this is because the data
> may have already been discarded, and that you can find such tests by
> either looking for the kunit_test_init_section_suites() macro or the
> is_init attribute.

Got it. I will definitely expand this more.

>
> > +
> > +Also, you cannot use this feature to run tests concurrently as there i=
s a
> > +mutex lock around running KUnit tests at the same time.
> > +
>
> Instead of mentioning the mutex, which is an implementation detail,
> just mention that tests will either wait for other tests to complete,
> or fail having timed out.
>

I will definitely switch this out in the next version.

>
>
> >  .. note ::
> >
> > -       If ``CONFIG_KUNIT_DEBUGFS`` is enabled, KUnit test results will
> > -       be accessible from the ``debugfs`` filesystem (if mounted).
> > -       They will be in ``/sys/kernel/debug/kunit/<test_suite>/results`=
`, in
> > -       TAP format.
> > +       For test authors, to use this feature, tests will need to corre=
ctly initialise
> > +       and/or clean up any data, so the test runs correctly a second t=
ime.
> > --
> > 2.43.0.rc2.451.g8631bc7472-goog
> >

