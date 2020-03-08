Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C733917D5F2
	for <lists+linux-arch@lfdr.de>; Sun,  8 Mar 2020 20:56:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726332AbgCHT4y (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 8 Mar 2020 15:56:54 -0400
Received: from mout.gmx.net ([212.227.15.15]:36435 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726322AbgCHT4y (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 8 Mar 2020 15:56:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1583697397;
        bh=38FDTv2DovrAZC0jG9Kb3CZj8F6XQ+T5cAYhHGRE+LU=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=XWTWpanP0PHP8JUViG23jLRgctrOIK++1hCLBOI02pwLGKARbIGTml4DevLtO8YKz
         jfzc5mYqVC8LWt0jf8yYXprvVJRaWDvpb1/ljwP0psd4m24VTgCEHa4h/eTdtmI1MX
         +BKD294dZEoLZxw2MsIFCMVZ+lZvEcv3wDvO1tuk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([37.201.214.212]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M6lpM-1jH5Vj00PG-008J6v; Sun, 08
 Mar 2020 20:56:37 +0100
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
Subject: [PATCH 1/3] docs: atomic_ops: Remove colons where they don't make sense
Date:   Sun,  8 Mar 2020 20:56:16 +0100
Message-Id: <20200308195618.22768-2-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200308195618.22768-1-j.neuschaefer@gmx.net>
References: <20200308195618.22768-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:S3Xm2L2CM68z7ATr6orhnChOL0WmFyPpp3u1n3QJokjgaYRpssY
 Z1i1bMoTuvK/Pihnj7mKINv2SOnf/ovYm00IwW8MkQFQ7dxKlS4L9aDqhly97JEY0hAfrG+
 6+yTf4u+GOyJLX4ucb8SRAZfFgtcJK6CQ7k9pafi9VKQPwFB92rVhMV2Xsk+yPqWXTRSWnA
 ciGIn+lT+gDmlGuz8DyPQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:AafdUW6kwkk=:I3BsMddyeZsvvG5Lu+ZKjR
 DfaugBml+lPtcouDSFmMNRnIdg93qYC7zPx4His+6HX22L22Xqrb/IgguP1S+G9ccYSCjzFZe
 TCOvB+rJACjIhAcxSEWHjRJqPwJ8yMHf19UOYykAh4d7Av+PXASSUwHdi/vtytlNckXJKcVai
 MZul+O/7Y7klKY5imM95sf3HCPpHngRVwgW7pBtweh5Vw/KVvYlIStxLBhJGAaYOEwctjeYF6
 wiMBmdq9WCYD+mjnx166iyMLR5sSNCh8rJbfnYtrgqSrP45xoehwyaymPNUjg4+jOMkbYFrOv
 hgnb9DgSCksg2aHkf5Wo6tFQrped69kJSGhuKBTkMNp8VDX04zN7VMbQDK40CkT2fAcT3S0/o
 lb6WLE6fdoPEwRXzH8x8cTWMMN2BSprtjX8PhlbVxT0FSrqrnWVdf7VxYBboWuwQe4e/sn9Bk
 t32SCPKjH4ZsVzPecORmP3pPzc7hjW4oD7RewVaqIQVarxNZScwsOyVkwrNhnW8gR5mo2x3os
 F23aci1gBg4iPsbB8UDXQK0vQyYcgcVh+AyClKt/VyIQd79fC3TaJ5bPR8fI4VyKCtS5DLSUt
 duoagei3VIHyqfrEDno09PEQzS9rBCkLiEoN+BTvIdsiZhi9OeWcxRunTnKI+LCXHTqnIeY/q
 BBW3i6Q4FYfzvG7Q84sws6oCRmu2XqSSkTkGdSOgqfssbPz8pbvp2e9iOlK42ZhpkiHorMU5j
 A+4Ytv6k+dZFPsv3uZ5LU/dHDwSgm+qN5OMZmwHAci3KNHuk7eBO/v7PkEh3RRb7A5MOzfcR9
 XYGTFRWUgTjCMYtFQEY3bgGZIKUzLLLiIoDlkIlaCim/BRc8O/Hos5JaS16htHhV+gd1EFViB
 +V4IKrhTnI9qc8+cjICqT5Nxh0cMYJsLpMSUJfsBK4uMHPBYKaTh+8TwykTJulr6SXe7vvf3Q
 d8NC7YB6/iOAyQ3XOne2Z+OeoJPHjYv/g31Kv/if6klyKFVQwbk8hYxrYkwShEvgNDF9TFxoR
 8R0kY9LP0LuioT/3ePSU+woD2T6ILuZE+srBlrMNi0t7R+rryCzoZLJOB8QA8mGqr+MHp96WE
 K1wMPdDkgYm7zk7G1Gys8cfuW3IPArqE7Z+9cb/hj+8GhtbKpc7XUP6GF8S7sH4M6UHwQ2tsM
 ZVMzm4T99nEm+I5Iveo9gz0mBVS42OW1Qh8WjOelVRiKx+pCNqt9dFnZM3pACgZ8UQB+pDGJu
 3rPvqQ/LzYhOybzqY
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

There are a few cases on atomic_ops.rst, where a end-of-line colon
before a code block seems semantically wrong, because the code block is
not related to the sentence before it.

End those lines with `. ::` instead, which is rendered as a period but
still formats the next line/block as a code block.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--
 Documentation/core-api/atomic_ops.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/core-api/atomic_ops.rst b/Documentation/core-ap=
i/atomic_ops.rst
index 724583453e1f..650b9693469a 100644
=2D-- a/Documentation/core-api/atomic_ops.rst
+++ b/Documentation/core-api/atomic_ops.rst
@@ -242,13 +242,13 @@ given atomic counter.  They return a boolean indicat=
ing whether the
 resulting counter value was zero or not.

 Again, these primitives provide explicit memory barrier semantics around
-the atomic operation::
+the atomic operation. ::

 	int atomic_sub_and_test(int i, atomic_t *v);

 This is identical to atomic_dec_and_test() except that an explicit
 decrement is given instead of the implicit "1".  This primitive must
-provide explicit memory barrier semantics around the operation::
+provide explicit memory barrier semantics around the operation. ::

 	int atomic_add_negative(int i, atomic_t *v);

=2D-
2.20.1

