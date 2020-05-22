Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 602921DEE3D
	for <lists+linux-arch@lfdr.de>; Fri, 22 May 2020 19:29:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730720AbgEVR3s (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 22 May 2020 13:29:48 -0400
Received: from merlin.infradead.org ([205.233.59.134]:48418 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730554AbgEVR3r (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 22 May 2020 13:29:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xp/n5IlXvNYZw1QeKHpP6RwwzQHWUekVgDIojWgljN4=; b=gOKxCu3cJi0QhaY/PHqOuAEj0C
        nguZNzHzd1uHaQ2IK91Bz0G7iqmIodCmPIX020e0af4N9LkKsB2ZH9GI9GK2uP0As8mrH/dOBIEvU
        OeERwnp2jVo2O50jF1bR5n9U+p/U/BkaO8V+0EwejxQaMcwtoYHvrBWyYFKNcvr1VizA5vHAxQVkZ
        1SiNEL+EwmW1tinerNONOO4poWq+RyvFdYBaMwf8M5G8W0h4EgN0D6eEJfO+glllebZ4t+OJXzVyE
        FLrEQCr0w6lhkqOyUOlrgf/3j2jxxfoL2C/eVxPvioBsXscLKWMK+BiM2Qh7MbGVSnGw1p6ZN6zuK
        daMDXh7g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jcBRx-0007SW-CE; Fri, 22 May 2020 17:27:13 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1FC98305E45;
        Fri, 22 May 2020 19:27:11 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0E41B20BDB12E; Fri, 22 May 2020 19:27:11 +0200 (CEST)
Date:   Fri, 22 May 2020 19:27:11 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
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
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>
Subject: Re: [RFC PATCH 5/5] selftest/x86: Add CET quick test
Message-ID: <20200522172711.GA317569@hirez.programming.kicks-ass.net>
References: <20200521211720.20236-1-yu-cheng.yu@intel.com>
 <20200521211720.20236-6-yu-cheng.yu@intel.com>
 <20200522092848.GJ325280@hirez.programming.kicks-ass.net>
 <202005221020.B578B8C6@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202005221020.B578B8C6@keescook>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, May 22, 2020 at 10:22:51AM -0700, Kees Cook wrote:

> But yes, I think getting a copy of asm.h would be nice here. I don't
> think the WRITE_ONCE() is needed in this particular case. Hmm.

Paranoia on my end because I had no clue wth he wanted with his -O0
magic gunk.
