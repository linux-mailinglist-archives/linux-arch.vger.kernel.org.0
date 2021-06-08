Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C048E3A07BA
	for <lists+linux-arch@lfdr.de>; Wed,  9 Jun 2021 01:20:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235351AbhFHXWo (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 8 Jun 2021 19:22:44 -0400
Received: from mail-pf1-f175.google.com ([209.85.210.175]:42978 "EHLO
        mail-pf1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235381AbhFHXWn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 8 Jun 2021 19:22:43 -0400
Received: by mail-pf1-f175.google.com with SMTP id s14so16028242pfd.9
        for <linux-arch@vger.kernel.org>; Tue, 08 Jun 2021 16:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UYnHXpjkxY6uN8Q/wAdT4oZuTb3kldbBA0o55ZnXLbI=;
        b=VDGAYt9zeOJIjafEo+B67uPbBGKQhrSGnf7Qo9Ch6H/mTASRST0oDv92Nf7ui6OeS8
         iB3NOQV0MMtCh2uBcA+Npibc6zFdC9xeu4KT1yRo8M0w7oGssOjX8MMlaVOz2EjWKrbi
         wCpTzbJv8yEONP8oFpas7EKEl1l7Ccqy2QOmo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UYnHXpjkxY6uN8Q/wAdT4oZuTb3kldbBA0o55ZnXLbI=;
        b=FmfN/QZCPV4tR5GVbjRnig7l7/qp1MHQP8hbArOeOG+pObYKqAtjn2kZHfUmJV8QCJ
         Zdsh09ScWfCmmIDB/u/G6zGaLAApYx6ybv9lazwFeN+tjJNlAaCFN+lC2+sqpVhrB+MG
         G6b9W1C0INg6Z/ze6xbK4fGhUaf2XDxur9nDO0BVrgxnheO+scZHl1+u+76lf+Q67Dd+
         gCSw6lbZ6aSqsYa3WPx+nb+OJ2mniA+TbFA+eHcXRcMxscGxBV25VquV1bSU3eoQb4g6
         b7pW14OyKI9CZQH/r3WLRg1TT2t55Hr5h6/YUZV02H3VWhqq5ObLqg7yq2XniNjoHqvu
         pJ1g==
X-Gm-Message-State: AOAM530lxJ5a5X9MURbiJov7CejOLdEbTdI1bYwoePoDzA1E6xJVu9sc
        iXth880DOZvaLLcANyydi7kEbw==
X-Google-Smtp-Source: ABdhPJy13j1j0ODNi7LI1+2LKQunbW8Wx/i0jcdBN55+DupC2NcBqv+Cq0yP0XhoUlI386xpojybKg==
X-Received: by 2002:a62:be03:0:b029:2e9:fe8c:effe with SMTP id l3-20020a62be030000b02902e9fe8ceffemr2325280pff.34.1623194373956;
        Tue, 08 Jun 2021 16:19:33 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id m2sm16400257pjf.24.2021.06.08.16.19.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 16:19:32 -0700 (PDT)
Date:   Tue, 8 Jun 2021 16:19:31 -0700
From:   Kees Cook <keescook@chromium.org>
To:     John Wood <john.wood@gmx.com>
Cc:     Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Arnd Bergmann <arnd@arndb.de>, Andi Kleen <ak@linux.intel.com>,
        valdis.kletnieks@vt.edu,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        kernel-hardening@lists.openwall.com
Subject: Re: [PATCH v8 0/8] Fork brute force attack mitigation
Message-ID: <202106081616.EC17DC1D0D@keescook>
References: <20210605150405.6936-1-john.wood@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210605150405.6936-1-john.wood@gmx.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Jun 05, 2021 at 05:03:57PM +0200, John Wood wrote:
> [...]
> the kselftest to avoid the detection ;) ). So, in this version, to track
> all the statistical data (info related with application crashes), the
> extended attributes feature for the executable files are used. The xattr is
> also used to mark the executables as "not allowed" when an attack is
> detected. Then, the execve system call rely on this flag to avoid following
> executions of this file.

I have some concerns about this being actually usable and not creating
DoS situations. For example, let's say an attacker had found a hard-to-hit
bug in "sudo", and starts brute forcing it. When the brute LSM notices,
it'll make "sudo" unusable for the entire system, yes?

And a reboot won't fix it, either, IIUC.

It seems like there is a need to track "user" running "prog", and have
that be timed out. Are there use-cases here where that wouldn't be
sufficient?

-Kees

-- 
Kees Cook
