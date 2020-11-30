Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9E0C2C8E84
	for <lists+linux-arch@lfdr.de>; Mon, 30 Nov 2020 20:57:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728122AbgK3T4p (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 30 Nov 2020 14:56:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726827AbgK3T4p (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 30 Nov 2020 14:56:45 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B51DC0613D4
        for <linux-arch@vger.kernel.org>; Mon, 30 Nov 2020 11:56:05 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id kk4so244621pjb.7
        for <linux-arch@vger.kernel.org>; Mon, 30 Nov 2020 11:56:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=DLtArDV8cKP0BeVklsVGWZ4r7522fWxRlpZkbLI2DME=;
        b=Kngn4LeLTwq4qYdSAXMCdhjRvG2+hfAwezvYYxclNLH4UYmaXcHHHm/oDA7haEQqo5
         cDgZ9CTL0bEBGcADB4JOqwDiXbdJifF4LwJgDbjttt2y9O+5miEIVUz2RYOGgeK4NbXj
         AZHT/WuYNGIuZ+g8cSddgDUX/X/wdLKAeH5yE1Nh6rDk+ejhrEqeGQWhdv05kN+gQ9Uh
         oOmj6zDFqIWJQpVkAoxeNann4anzRJS+12uX8GB2/354ozUtuLyoprqIvdEFHrYVQBXR
         J0hiCEXvI45QzTD2c934ITS2t0agvN8pr8586/Tl43yb3ixwscsBmaJeFId+9Gzx78bV
         bteQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=DLtArDV8cKP0BeVklsVGWZ4r7522fWxRlpZkbLI2DME=;
        b=cZjBJneXohQgCwrFElN8L/s7IffVolp3pjxHbALEfbJftOU1LQmYPtvERXdMMBc1Ak
         wu7SZzxqE7RDP17Sd/UK35yYtqde2J2sxDUUmmy5nVdzrf+RmUxHhbKtjS6xFG8vmVAR
         uDNCh838+KX94vNsw/j/AN+oZYdzWZkCfPicBIOxXEwU7onouDwKWw826V8rnYR2wf8a
         caoTJE6aYe5kI/x+7FhyAPCmQ4FRmr5rJf9ecm9snlwMq3voW8ooFNvUxfezDeVfvljT
         Ap776v8YC/YK8MKg96gt7FFkMy2AjqJycnMhBtdHN1LeKK6qJ6/XWYYeHs0OXlNg4M8k
         NN/Q==
X-Gm-Message-State: AOAM532Gqq9aCReJP2Rb9Zkv9cl7MyRH9Zszdh2QLg/d+g6Lt0Oildp3
        QcVIuzxMX1UA3r67+YmhJkQzWg24qXFN9ELyOiI=
X-Google-Smtp-Source: ABdhPJzB688RhMdWZtegBv6aVz52FbjVdJ0Q+QuBT876w4Q6KmkjclwwABgZ0Hd+nwZUsJGEaNoSrmQC9+tOAwhsDUU=
Sender: "ndesaulniers via sendgmr" 
        <ndesaulniers@ndesaulniers1.mtv.corp.google.com>
X-Received: from ndesaulniers1.mtv.corp.google.com ([2620:15c:211:202:f693:9fff:fef4:4d25])
 (user=ndesaulniers job=sendgmr) by 2002:a17:90a:f28f:: with SMTP id
 fs15mr495886pjb.121.1606766164462; Mon, 30 Nov 2020 11:56:04 -0800 (PST)
Date:   Mon, 30 Nov 2020 11:56:02 -0800
In-Reply-To: <20201110162211.9207-6-yu-cheng.yu@intel.com>
Message-Id: <20201130195602.331842-1-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20201110162211.9207-6-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: Re: [PATCH v15 05/26] x86/cet/shstk: Add Kconfig option for user-mode
 Shadow Stack
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     yu-cheng.yu@intel.com
Cc:     Dave.Martin@arm.com, arnd@arndb.de, bp@alien8.de,
        bsingharora@gmail.com, corbet@lwn.net, dave.hansen@linux.intel.com,
        esyr@redhat.com, fweimer@redhat.com, gorcunov@gmail.com,
        hjl.tools@gmail.com, hpa@zytor.com, jannh@google.com,
        keescook@chromium.org, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, luto@kernel.org,
        mike.kravetz@oracle.com, mingo@redhat.com, nadav.amit@gmail.com,
        oleg@redhat.com, pavel@ucw.cz, pengfei.xu@intel.com,
        peterz@infradead.org, ravi.v.shankar@intel.com,
        rdunlap@infradead.org, tglx@linutronix.de,
        vedvyas.shanbhogue@intel.com, weijiang.yang@intel.com,
        x86@kernel.org, Sami Tolvanen <samitolvanen@google.com>,
        Will Deacon <will@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

In response to https://lore.kernel.org/lkml/20201110162211.9207-6-yu-cheng.yu@intel.com/.

Hi Yu-cheng,
This feature reminds me very much of
ARCH_SUPPORTS_SHADOW_CALL_STACK/CC_HAVE_SHADOW_CALL_STACK implemented in
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=5287569a790d2546a06db07e391bf84b8bd6cf51.

Do you think it would be worthwhile to share the same config name between x86
and aarch64?

(Though, it seems on x86 there will be a distinction between kernel mode and
user mode configs, if I understand correctly?)
