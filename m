Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5F5E3B1D21
	for <lists+linux-arch@lfdr.de>; Wed, 23 Jun 2021 17:04:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230392AbhFWPGx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 23 Jun 2021 11:06:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:42043 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229523AbhFWPGv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Wed, 23 Jun 2021 11:06:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624460673;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=eixFFTwOGQ1ExxeugHIxMEh4+ha/qgZf+CuKnD4kIYs=;
        b=XS3i89ZMsOeZkRpPybLoMTMJPaUwFz0VRkD/c4/TuEgxRCBcFAy17gOrs8bRgXVeb+CVZN
        hV5SL7nIRQXUeKnrDEZLtAVJJ0vuDqYo/PF2Je1mSgntSte3NJeRGi9LoMJk0lPTycoONo
        fJg7kRgrr8f+BmZQtUfNPlSJfu51HMw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-506-Ke3j29BRNyiqdD_P-NaYnw-1; Wed, 23 Jun 2021 11:04:32 -0400
X-MC-Unique: Ke3j29BRNyiqdD_P-NaYnw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E4FF5100CA88;
        Wed, 23 Jun 2021 15:04:30 +0000 (UTC)
Received: from oldenburg.str.redhat.com (ovpn-112-211.ams2.redhat.com [10.36.112.211])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8412660C05;
        Wed, 23 Jun 2021 15:04:29 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     libc-alpha@sourceware.org, linux-api@vger.kernel.org,
        x86@kernel.org, linux-arch@vger.kernel.org
Cc:     "H.J. Lu" <hjl.tools@gmail.com>
Subject: x86 CPU features detection for applications (and AMX)
Date:   Wed, 23 Jun 2021 17:04:27 +0200
Message-ID: <87tulo39ms.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

We have an interface in glibc to query CPU features:

  X86-specific Facilities
  <https://www.gnu.org/software/libc/manual/html_node/X86.html>

CPU_FEATURE_USABLE all preconditions for a feature are met,
HAS_CPU_FEATURE means it's in silicon but possibly dormant.
CPU_FEATURE_USABLE is supposed to look at XCR0, AT_HWCAP2 etc. before
enabling the relevant bit (so it cannot pass through any unknown bits).

It turns out we screwed up in the glibc 2.33 release the absolutely
required headers weren't actually installed:

  [PATCH] x86: Install <bits/platform/x86.h> [BZ #27958]
  <https://sourceware.org/pipermail/libc-alpha/2021-June/127215.html>

Given that the magic constants aren't available in any other way, this
feature was completely unusable, so we can perhaps revisit it and switch
to a different approach.

Previously kernel developers have expressed dismay that we didn't
coordinate the interface with them.  This is why I want raise this now.

When we designed this glibc interface, we assumed that bits would be
static during the life-time of the process, initialized at process
start.  That follows the model of previous x86 CPU feature enablement.
In the background, CPU_FEATURE_USABLE/HAS_CPU_FEATURE calls a function
which returns a pointer to eight 32-bit words, based on the index passed
to the function (out-of-range indidces return a pointer to zeros,
enabling forward compatibility).  The macros then use a magic constants
that encodes he lookup index and which of those 128 bits to extract to
find that bit, plus the feature/usable choice.  This means that we
*could* keep this interface unchanged if the kernel gives us a way to
read up-to-date feature state from a 256 bit area (or at least 32 bit
word) in thread-specific data.  Similar to what we have with
set_robust_list and rseq today.

This still wouldn't cover the enable/disable side, but at least it would
work for CPU features which are modal and come and go.  The fact that we
tell GCC to cache the returned pointer from that internal function, but
not that the data is immutable works to our advantage here.

On the other hand, maybe there is a way to give users a better
interface.  Obviously we want to avoid a syscall for a simple CPU
feature check.  And we also need something to enable/disable CPU
features.

Thanks,
Florian

PS: Is it true that there is no public mailing list for Linux
discussions specific to x86?

