Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90FA417D5F5
	for <lists+linux-arch@lfdr.de>; Sun,  8 Mar 2020 20:57:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbgCHT5B (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 8 Mar 2020 15:57:01 -0400
Received: from mout.gmx.net ([212.227.17.22]:51669 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726322AbgCHT5B (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 8 Mar 2020 15:57:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1583697399;
        bh=swNXo8sf/A1Z5VWORhX8PS1wDsET0aIhHcJl33nMJa8=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=XhvPeb8bgnV8/IAZQYhe/hBjChfjtsV2UMgFtqhaOL5BS/3xv4J3BpoI30BZZeYHj
         WX5GGb2vn2CWJy0MbyesiPpMF5lu0tn2Uuk2tORAQ2OjYBbNqnBSrmsThmtLgO7fEY
         dCWUb/M3NkEz8LeoFDl9XdlfbDqewIT7ZMX9UJOo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([37.201.214.212]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M2f5T-1jCOYC0l9b-0048U7; Sun, 08
 Mar 2020 20:56:39 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-doc@vger.kernel.org
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Subject: [PATCH 2/3] docs: atomic_ops: Move two paragraphs into the warning block above
Date:   Sun,  8 Mar 2020 20:56:17 +0100
Message-Id: <20200308195618.22768-3-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200308195618.22768-1-j.neuschaefer@gmx.net>
References: <20200308195618.22768-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:eVTShVIjcqITjrjrt3hSHiQJv3jRqCqEsB/zW9mt8QRJpl3Bw/Q
 pgjPvWebRuAt+Z7AqwbkR0NHGm+Mm2cImwkAJHZPlOG6bAhuNsXQZDPRFuP8+dpaZyeDulG
 GaSr0Boj5Wr/mzdrrVZU2ADCOQkWfb+5VMomxXAp8wfAm3wPYWtn1JyxKGeHazSpBpa7+KJ
 4xcal4jwbfV+a5j6sJ0vg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Nwpz9xQ4q4A=:n8BILpeGYEEWHtbCQXwwu6
 ZF3mJ/j8kyR9jC+o5rYWTLcG3m3qFTuPrIEhVJvSxusZgBTVxjoV1Jemr0r+kw5yAb+/cwBRi
 TTvKUE0H/6hw3WfDA9vMuPik2wLESjCyujVEa1bl8m4b7HfhJOma46u073lbk9D5BcBhedOQv
 2GhbhMQoGrLSDZNroBSNqA8/QBqh2pDwOmXfvxm22XTCgkbr3OUiGpKqfxN5+M6azwSVQLwf/
 0UQEu4WSQis8I4WX+EwK1V/daC6wAghUMUnGwzfv4USByXOTXJChv5Dwj9PzRitFfczN3iH5r
 yQBYHLzY6FBV+LdjfCm3PPXo5F5eqh5Lj736+xmeEp7LjsvfjJ5N4pdv+/JnOmOtdnpttnovZ
 a+5rmFBC6DRcdAROx+xgPbIUnRbByCsmweaIYKzRRagTMtizZoqwjR65G8PSqNFP6ATGzLY2B
 LDsyL0JOL3IF0fMqtFOUTZhInvKTACesFyHYoPkiB+nPwEHj4ZzhC1fSnLbYdQkJ03E+pXAOu
 xDzvd7MmB2pBoKiXXNkf99DTBonzN0u2F9UaoxQe4+JISTMXeEXo9tvD9eaZzdaFSEL1dvf4/
 owrTRjU30k45Oyj2G+bWS/KIQEMuZ0UVCg1cQor4BNNXDfUpJpqrRHT3qXJU/G5bJW5cDBwmQ
 DOdZjU06kg4okRjyfFDEpsA+rGYyCNh/8QxG2j9gcxksiWQdyetzDT0EoazA/OH3VaHpj2ren
 +qY0KUCRVkyy93WUzj7nxJLltLVPYYKcDbSKUaFpnclORKcDkj9/lEC53YVYz5aj3K/79yOg1
 4wSK/2vVhBwY8rpC2IyN5Ze5+yItUvMbg1E9U/cWdKUjK59aU4QyE9f77sCKpDQtx/WZCrjwr
 cYQVC3UkHdnzypgOfuAWxGLBe02NAVdLZ3nd44aQOcgOAOeePtEl6q5axrTKDVJ2ZBSE2JRra
 +gOSjuD4Qt9bWtmGJTM71SEJlX6GUwBGWTNfykfBikhwRXyg5+GFuM5OGHNMOGdBMbLfF5aPf
 CzHC2kUOGcaPnsNyhAtnIpSuYCkdj8zBB08u1LeJ/mAvnEQSf0eO9tmzlXwU60bauy9PAX2Jb
 hJmJyjCQI6LtyiJ+FVcXql8IKI0wiu81DsKTBbbRAxfihou4QnA+3mbabgYfjVekV/wC+c8un
 Y8a0GR8/ouCsU9r26p4OtivdZxJyKGxpVCcT4D5GDljlnp9cEA44kXxWSXhxLV1+oyXIyEl2R
 mCewJvfEjAf1m1qEX
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

These two paragraphs seem to be semantically part of the warning text,
so let's adjust the formatting accordingly.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--
 Documentation/core-api/atomic_ops.rst | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/Documentation/core-api/atomic_ops.rst b/Documentation/core-ap=
i/atomic_ops.rst
index 650b9693469a..73033fc954ad 100644
=2D-- a/Documentation/core-api/atomic_ops.rst
+++ b/Documentation/core-api/atomic_ops.rst
@@ -473,14 +473,14 @@ operation.
         above to return "long" and just returning something like "old_val=
 &
         mask" because that will not work.

-For one thing, this return value gets truncated to int in many code
-paths using these interfaces, so on 64-bit if the bit is set in the
-upper 32-bits then testers will never see that.
-
-One great example of where this problem crops up are the thread_info
-flag operations.  Routines such as test_and_set_ti_thread_flag() chop
-the return value into an int.  There are other places where things
-like this occur as well.
+        For one thing, this return value gets truncated to int in many co=
de
+        paths using these interfaces, so on 64-bit if the bit is set in t=
he
+        upper 32-bits then testers will never see that.
+
+        One great example of where this problem crops up are the thread_i=
nfo
+        flag operations.  Routines such as test_and_set_ti_thread_flag() =
chop
+        the return value into an int.  There are other places where thing=
s
+        like this occur as well.

 These routines, like the atomic_t counter operations returning values,
 must provide explicit memory barrier semantics around their execution.
=2D-
2.20.1

