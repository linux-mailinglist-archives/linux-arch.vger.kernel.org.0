Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7CDA2C61AD
	for <lists+linux-arch@lfdr.de>; Fri, 27 Nov 2020 10:29:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726014AbgK0J3L (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 27 Nov 2020 04:29:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbgK0J3L (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 27 Nov 2020 04:29:11 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5C03C0613D1;
        Fri, 27 Nov 2020 01:29:10 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id b6so4030157pfp.7;
        Fri, 27 Nov 2020 01:29:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RD6BXGXgO5CkMS1mHQzAuQIHEBQtva6qzduS8cHE1ak=;
        b=XZbRNFvMHGzqw3bLgf59ondA9kkygmg6jqtpAFk94WvpJxvJeldgSS5qJBzJ7C4lzP
         qRp2k6/gop1vLoyCr9qV7cNTpTTYBfEDe1zkGvA9eTJZRzatLurVE/APAWoXPYi/kBR4
         htmYkZF00nVDv/43zPiXOzETimbCd3M/EMLKx0VaxTeHfzreYrmWEcY1r6ZTztlDqk7f
         yTkxytMYmyiXtA8nUokbc1LRilU6msBzwo7q0rB1hqwLqg3zifZCzQIc/Lyxp8HhGZoP
         CRapDt2mr1c9OZQE39C2GAYex+HKILxTVbXlsZOOh70EDma1OswVCDZlkDX+kdIES4ZI
         3DPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RD6BXGXgO5CkMS1mHQzAuQIHEBQtva6qzduS8cHE1ak=;
        b=FD8Ydx4psHR9fmKORn0mmxg1SPO7YiYOkjSSFXz3oKgu6uAOv+gdcEBi3Oi6pJcf1e
         anUuCe2grwIE2lHRIbJ08KHEXTyrnu67u0YoIBSEGfT0ry2FYNGhO4pzsadlAYqRyx2m
         Dk+cGRf1JFkpuzCWS6fW+MrzTH6T+idXjj/TxaokQqxUh4bwe27jRVxemVpveGl8KBKj
         NYcZal02BrSo4PMuziZ4SQBotJjhBS2uI5ss1h2HwvO+C2iN3rkEISny56B78QPaFZey
         dRCM4HfssmwGI/8tyQmsTP9ugaa+cS0oLbfPKnE+a9c/nuFB0DQoH/sMsC1zV5v2QShy
         IXMQ==
X-Gm-Message-State: AOAM533QSy34aMmnqi3i8luxTJJmtm9oIS4KjvsSdnhDlTV+cJq9tGX1
        qtU4ZCBl0uEs0LCoiEMaMug=
X-Google-Smtp-Source: ABdhPJwKpcDRzKgCp6wpeBmbZQrSoxpmlCTjlyLLL8vBlwesx5hY7wWA+FRvpV0orAH0nIbVhvXmvw==
X-Received: by 2002:a17:90a:c214:: with SMTP id e20mr8884618pjt.212.1606469350377;
        Fri, 27 Nov 2020 01:29:10 -0800 (PST)
Received: from localhost (61-68-227-232.tpgi.com.au. [61.68.227.232])
        by smtp.gmail.com with ESMTPSA id gg22sm8983689pjb.7.2020.11.27.01.29.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2020 01:29:09 -0800 (PST)
Date:   Fri, 27 Nov 2020 20:29:05 +1100
From:   Balbir Singh <bsingharora@gmail.com>
To:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
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
        Weijiang Yang <weijiang.yang@intel.com>,
        Pengfei Xu <pengfei.xu@intel.com>
Subject: Re: [PATCH v15 00/26] Control-flow Enforcement: Shadow Stack
Message-ID: <20201127092905.GB473773@balbir-desktop>
References: <20201110162211.9207-1-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201110162211.9207-1-yu-cheng.yu@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Nov 10, 2020 at 08:21:45AM -0800, Yu-cheng Yu wrote:
> Control-flow Enforcement (CET) is a new Intel processor feature that blocks
> return/jump-oriented programming attacks.  Details are in "Intel 64 and
> IA-32 Architectures Software Developer's Manual" [1].
> 
> CET can protect applications and the kernel.  This series enables only
> application-level protection, and has three parts:
> 
>   - Shadow stack [2],
>   - Indirect branch tracking [3], and
>   - Selftests [4].
> 
> I have run tests on these patches for quite some time, and they have been
> very stable.  Linux distributions with CET are available now, and Intel
> processors with CET are becoming available.  It would be nice if CET
> support can be accepted into the kernel.  I will be working to address any
> issues should they come up.
>

Is there a way to run these patches for testing? Bochs emulation or anything
else? I presume you've been testing against violations of CET in user space?
Can you share your testing?
 
Balbir Singh.
