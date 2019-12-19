Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F8C9126104
	for <lists+linux-arch@lfdr.de>; Thu, 19 Dec 2019 12:39:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbfLSLjv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 19 Dec 2019 06:39:51 -0500
Received: from ozlabs.org ([203.11.71.1]:49947 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726668AbfLSLju (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 19 Dec 2019 06:39:50 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 47dqfp0phfz9sPK;
        Thu, 19 Dec 2019 22:39:45 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1576755588;
        bh=rOd+nUIEAzAccp3PvRcR200yxlaugVwsQre4gumsVdc=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=GuBNNihEtBtqIz8PqGhjM6g/zMOYVEL6mEUgziDE4XQ5A0lV69T+E/Z4FygDzUKYi
         1aB5r22ApjjAnp1a9bLKTD9Gculf/iN3v3eQvfR+mlLqBCS60Ja+CHq3Sa8xEfW/+I
         G0Y643D0cLV2B2hR8Dz8aZiFiCuQkumA0c4z3JkETsq1/vVrrsa8HAOuUVyWt8iT4M
         EO0q/UZCm+qtb6LF8+yC/e1e9hGQJaJDC/X4LPpXaFB3BLOzQEIjxCgmOJO7jmre7W
         NINk2k5dK/lpnVKR9izw+rp0NRUsbiMWnkYJZFzIoxz7TucWhPhAKY3hSCmLFlidPK
         q6UYMkUn/tGHA==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Dave Hansen <dave.hansen@intel.com>,
        Michal =?utf-8?Q?Such=C3=A1nek?= <msuchanek@suse.de>
Cc:     linux-arch@vger.kernel.org, fweimer@redhat.com,
        aneesh.kumar@linux.ibm.com, x86@kernel.org, linuxram@us.ibm.com,
        shuahkh@osg.samsung.com, mhocko@kernel.org, linux-mm@kvack.org,
        mingo@redhat.com, Sandipan Das <sandipan@linux.ibm.com>,
        linux-kselftest@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        bauerman@linux.ibm.com
Subject: Re: [PATCH v15 06/23] selftests/vm/pkeys: Typecast the pkey register
In-Reply-To: <15c3b6cc-d8da-9a32-da6a-4c3990f48994@intel.com>
References: <cover.1576645161.git.sandipan@linux.ibm.com> <719ec65756a64cc03e8464a9c6da51c4519d2389.1576645161.git.sandipan@linux.ibm.com> <5b6c3f8a-9d2f-2534-c072-89f130ce110f@intel.com> <20191218205905.GG4113@kitsune.suse.cz> <15c3b6cc-d8da-9a32-da6a-4c3990f48994@intel.com>
Date:   Thu, 19 Dec 2019 22:39:44 +1100
Message-ID: <87d0ckmtmn.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Dave Hansen <dave.hansen@intel.com> writes:
> On 12/18/19 12:59 PM, Michal Such=C3=A1nek wrote:
>>> I'd really just rather do %016lx *everywhere* than sprinkle the
>>> PKEY_REG_FMTs around.
>> Does lx work with u32 without warnings?
>
> Either way, I'd be happy to just make the x86 one u64 to make the whole
> thing look more sane,

It's userspace so you don't get u64, you only get __u64.

And then you'll hit the fact that by default __u64 is unsigned long on
powerpc and unsigned long long on x86, meaning you still can't use the
same printf specifier.

To avoid that you should define __SANE_USERSPACE_TYPES__ before
including any headers, and then you'll get unsigned long long for __u64
everywhere and you can just use %llx.

cheers
