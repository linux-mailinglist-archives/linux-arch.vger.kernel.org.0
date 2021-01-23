Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 576563014DA
	for <lists+linux-arch@lfdr.de>; Sat, 23 Jan 2021 12:22:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbhAWLWQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 23 Jan 2021 06:22:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726451AbhAWLWP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 23 Jan 2021 06:22:15 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94FB1C06174A;
        Sat, 23 Jan 2021 03:21:34 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id 6so11369584ejz.5;
        Sat, 23 Jan 2021 03:21:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version;
        bh=tCJVoQC4xBY3BGtp3Oi80kGjpZ26JA6I+lIE3EpCRh0=;
        b=hytw3ianpw4z4IdU1YPAg0GhJMxNxjd110yTuneOWwxJVJgn/u/pVLYBbA9IDChGFY
         n+/EsGqL5uVQAq4K+H29xyPc1NSJBTpSxx8gxnorZ9paSAxRjT8sr9Vvi9hrGZJfJCaD
         /9kEUj8uh+Wy+S0F9BCsvlyhpzo+ywNfZvppRQFllw7eK41yzQPJ/0+t8OJOfR7y8aGe
         fsziO0cikKu5iR9boDrBab3Z4vEIfbjCTBo8XuqRNkDg6pIEs77UsyW5aTdVYG+j6n9B
         8Y7fXo/Pz/UByPlTEfiDe9U5ZX1I2siZjr09MOhwvx5NSiq0hV9cLCiQfMuCpjvFPSDm
         nd8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version;
        bh=tCJVoQC4xBY3BGtp3Oi80kGjpZ26JA6I+lIE3EpCRh0=;
        b=Qak0ABrONvP0oHhyv1cfrR0+CMB6eeuxFYT/s90Q7Ahg6oqHXLnTNas689Pq+c3rQC
         DcJokuxWlIKpvsEfC232woR2A6eMLMfxc+fFtM8S0LCg6C7n+Eoc5+xZM/7EYyJSFhkx
         xTCbNq7R4ZhB2lP+3WGc5OtzLPrgHb1kVeXZutBJudAn/PzQB1/HFgYaKMaWzRML0Ybu
         VIjvUOCJrPg0Pj3Mv/TiffhGGcBhKx8Z8RmvXSU/3fNkjIc30rAye1tfTfqOxLWtwyJg
         VGjBfuESTcT64PlNUh/cJc5h0b/8QHftl4rdy2teGRmQNVJAVIvskkhmI6wjODmIOt1l
         ZFYA==
X-Gm-Message-State: AOAM532c098OczLT+GOm6l21Q0oe270PZHKQT9i9BRL6UsKF+grOpZcb
        zQ05M/IOWYJj5FD1eEKUq4DoEaHWUOJNjQ==
X-Google-Smtp-Source: ABdhPJxncUjn1LRbw7PboCskFi9l+SgUcnUBCQtRag/N1CjcyStamRSkapMhdaUtcSe34VBEDO4Wyw==
X-Received: by 2002:a17:906:19c3:: with SMTP id h3mr408122ejd.429.1611400893038;
        Sat, 23 Jan 2021 03:21:33 -0800 (PST)
Received: from localhost (cpc158799-hari22-2-0-cust25.20-2.cable.virginm.net. [82.3.12.26])
        by smtp.gmail.com with ESMTPSA id a11sm7064797edt.26.2021.01.23.03.21.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Jan 2021 03:21:32 -0800 (PST)
Date:   Sat, 23 Jan 2021 03:21:32 -0800 (PST)
X-Google-Original-Date: Sat, 23 Jan 2021 10:56:48 +0000
 From 3920487b3156cc2f90ebbb7d018c9f3f34637d62 Mon Sep 17 00:00:00 2001
From:   Yuxuan Shui <yshuiv7@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     krisman@collabora.com, linux-arch@vger.kernel.org,
        kernel@collabora.com, yshuiv7@gmail.com
Subject: [PATCH] ptrace: restore the previous single step reporting behavior
Message-ID: <877do3gaq9.fsf@m5Zedd9JOGzJrf0>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Commit 64eb35f701f04b30706e21d1b02636b5d31a37d2 changed when single step
is reported.

Specifically, the report_single_step is changed so that single steps are
only reported when both SYSCALL_EMU and _TIF_SINGLESTEP are set, while
previously they are reported when _TIF_SINGLESTEP is set without
_TIF_SYSCALL_EMU being set.

This behavior change breaks rr [1]

This commit restores the old behavior.

[1]: https://github.com/rr-debugger/rr/issues/2793

Signed-off-by: Yuxuan Shui <yshuiv7@gmail.com>
=2D--
 kernel/entry/common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index 90533f34ea99c..ad3b17fcde782 100644
=2D-- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -220,7 +220,7 @@ static inline bool rep:ort_single_step(unsigned long wo=
rk)
  */
 static inline bool report_single_step(unsigned long work)
 {
=2D	if (!(work & SYSCALL_WORK_SYSCALL_EMU))
+	if (!!(work & SYSCALL_WORK_SYSCALL_EMU))
 		return false;
=20
 	return !!(current_thread_info()->flags & _TIF_SINGLESTEP);
=2D-=20
2.30.0


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEL6EJkr0WlitWahBy06RAW+bMF/QFAmAMBrMACgkQ06RAW+bM
F/SE6w/+LKNStNWKuVgglb2MGrIdELiwmsxyXVsjKQVZ0+9qnYtrWzq+l+tXzbaH
erPZaiQiDBaUw98qlv+d6/Bhkj8iJgMP9NghCjw24BaIfYSoyDYA+YiKRp941m4s
pRGfNon3pdAN3Z7K2a6ZNUqSALB0zFsOdqaS95kV9iU/h07ISiRjneYXuUzFDMkL
/5J4zWj3Ut0P3/2HU3u7JekplTa/EKPKXF8CuBzFygQ5yaFl5mRiAUZP+LDzbJXq
8xdy7FhLBI6Aj5Yz7XDSde5aLYp62LhQi9WSv6SCCAYrntH7UqwrsLRpATv84HlF
8heFxZw5wYSZSgo7iWxHURZ7FXiZIxdyoRuS4ZzT9NfwlW5yjbgZZoQHmUEkbRdM
neSBSvh/7w3vwvNIkxhX2Ga+VH+9X3zS6WlJOGpSq2+HnzBsDsFFld7lvsmxKV7L
RmSXFoJfQ5KsDJlASoWk7IsNr+1ch9uSZxAzz5345pETZLzdxvwY+G9D6BtSqw47
dm0id9NRGAsn59npB53IxGN/f+u3bH+nODBkZB8FLa+FBxHa52PBkJ5BWrpV/kpU
0wP8dHKHnWZa2DxwpLBdV6QjtQD3X9NhjWRlEAvQwltpL04jqQp5tVeFW2Nu0Dtd
WgiT+4zVvwbPecZ8DhbBEubzA3PQ597utf3zTPQOxrTpTg4Msl4=
=OVRe
-----END PGP SIGNATURE-----
--=-=-=--
