Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B9561DD0F0
	for <lists+linux-arch@lfdr.de>; Thu, 21 May 2020 17:16:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729894AbgEUPQ1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 21 May 2020 11:16:27 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:52727 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727898AbgEUPQ0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 21 May 2020 11:16:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590074185;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1jYcpHnQL3yWssjgDciSJYss0+WKenYias59GqFdGbA=;
        b=iBbdXmtYwqbaZHtRXbFaX55NpV/NX0zy5I+EPLdxt4IHmIh/8fIf5rqXVtZQGkVFntNymg
        LueazZJaovAJDDN7pBF4uVK7sZx2d9CAZb7nOjNAIF1zrI/cux6+U78k85wKYU7aiHEwCt
        33GT3ZJeC4GAaL7O54KZf2E/fPb9ulQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-12-QcU_r6aePH625lEdCeW_7g-1; Thu, 21 May 2020 11:16:21 -0400
X-MC-Unique: QcU_r6aePH625lEdCeW_7g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B2AB3100D0DB;
        Thu, 21 May 2020 15:16:17 +0000 (UTC)
Received: from treble (ovpn-112-59.rdu2.redhat.com [10.10.112.59])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0F010106A7B7;
        Thu, 21 May 2020 15:15:58 +0000 (UTC)
Date:   Thu, 21 May 2020 10:15:56 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>
Subject: Re: [PATCH v10 00/26] Control-flow Enforcement: Shadow Stack
Message-ID: <20200521151556.pojijpmuc2rdd7ko@treble>
References: <20200429220732.31602-1-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200429220732.31602-1-yu-cheng.yu@intel.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Apr 29, 2020 at 03:07:06PM -0700, Yu-cheng Yu wrote:
> Control-flow Enforcement (CET) is a new Intel processor feature that blocks
> return/jump-oriented programming attacks.  Details can be found in "Intel
> 64 and IA-32 Architectures Software Developer's Manual" [1].
> 
> This series depends on the XSAVES supervisor state series that was split
> out and submitted earlier [2].
> 
> I have gone through previous comments, and hope all concerns have been
> resolved now.  Please inform me if anything is overlooked.
> 
> Changes in v10:

Hi Yu-cheng,

Do you have a git branch with the latest Shadow Stack and IBT branches
applied?  I tried to apply IBT v9 on top of this, but I guess the SS
code has changed since then and it didn't apply cleanly.

-- 
Josh

