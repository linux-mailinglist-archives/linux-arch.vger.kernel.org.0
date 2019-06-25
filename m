Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A247E5530A
	for <lists+linux-arch@lfdr.de>; Tue, 25 Jun 2019 17:15:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731408AbfFYPPc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 25 Jun 2019 11:15:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42947 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730505AbfFYPPc (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 25 Jun 2019 11:15:32 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 682CB2E95B5;
        Tue, 25 Jun 2019 15:15:32 +0000 (UTC)
Received: from oldenburg2.str.redhat.com (dhcp-192-180.str.redhat.com [10.33.192.180])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0479B5D71B;
        Tue, 25 Jun 2019 15:15:28 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     linux-api@vger.kernel.org, kernel-hardening@lists.openwall.com,
        linux-x86_64@vger.kernel.org, linux-arch@vger.kernel.org
Cc:     Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Carlos O'Donell <carlos@redhat.com>
Subject: Detecting the availability of VSYSCALL
Date:   Tue, 25 Jun 2019 17:15:27 +0200
Message-ID: <87v9wty9v4.fsf@oldenburg2.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Tue, 25 Jun 2019 15:15:32 +0000 (UTC)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

We're trying to create portable binaries which use VSYSCALL on older
kernels (to avoid performance regressions), but gracefully degrade to
full system calls on kernels which do not have VSYSCALL support compiled
in (or disabled at boot).

For technical reasons, we cannot use vDSO fallback.  Trying vDSO first
and only then use VSYSCALL is the way this has been tackled in the past,
which is why this userspace ABI breakage goes generally unnoticed.  But
we don't have a dynamic linker in our scenario.

Is there any reliable way to detect that VSYSCALL is unavailable,
without resorting to parsing /proc/self/maps or opening file
descriptors?

Should we try mapping something at the magic address (without MAP_FIXED)
and see if we get back a different address?  Something in the auxiliary
vector would work for us, too, but nothing seems to exists there
unfortunately.

Thanks,
Florian
