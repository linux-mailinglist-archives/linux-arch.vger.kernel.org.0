Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF48737EA8
	for <lists+linux-arch@lfdr.de>; Thu,  6 Jun 2019 22:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726406AbfFFUZh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 6 Jun 2019 16:25:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:58288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726245AbfFFUZg (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 6 Jun 2019 16:25:36 -0400
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2CFE32133D
        for <linux-arch@vger.kernel.org>; Thu,  6 Jun 2019 20:25:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559852736;
        bh=DKhd22QxqBDA4KYT2cEZlqhYj/PumKxUwK/zMkdDIFM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=G0CVtpqeJtYYi6ZVaBFtvvXvsAJWteRf+Hozt3FdnG/AgCfB13Ad6uwZ0nLaLABj2
         Ly/i51Lug8kHTeKHt0sOEyAEaFq4S0eb4MTCLoZsHoQIebL3w5+kFZd//YQMmGUiXU
         4WkplG7Ari2A2w0tOQzaO/RkIK0JrHzIWXgmzQyU=
Received: by mail-wr1-f41.google.com with SMTP id x17so3732168wrl.9
        for <linux-arch@vger.kernel.org>; Thu, 06 Jun 2019 13:25:36 -0700 (PDT)
X-Gm-Message-State: APjAAAXJmL+DlDm5VdO7TwTeOXFtW1OsGFoE0Paqa7JZDBMpmGBpl7Xm
        mngMcMhYxY3hHrKPe2QBSuxSFgz+oL6X8LP2jth2aQ==
X-Google-Smtp-Source: APXvYqyiVg/qughgzdZroKp3BApJXIniApUU+56AdTnkB3j3XqqcAGvsvRwbxtgUhLtiuuaGb5s/W6OHjaS71guGj14=
X-Received: by 2002:adf:f2c8:: with SMTP id d8mr4513620wrp.221.1559852734693;
 Thu, 06 Jun 2019 13:25:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190606200926.4029-1-yu-cheng.yu@intel.com> <20190606200926.4029-11-yu-cheng.yu@intel.com>
In-Reply-To: <20190606200926.4029-11-yu-cheng.yu@intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 6 Jun 2019 13:25:23 -0700
X-Gmail-Original-Message-ID: <CALCETrUZ9vu8+9WrMcMdV6DvmB3nRQmLjd5_uDk8x1NMQUtPpg@mail.gmail.com>
Message-ID: <CALCETrUZ9vu8+9WrMcMdV6DvmB3nRQmLjd5_uDk8x1NMQUtPpg@mail.gmail.com>
Subject: Re: [PATCH v7 10/14] x86/vdso/32: Add ENDBR32 to __kernel_vsyscall
 entry point
To:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc:     X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
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
        Dave Martin <Dave.Martin@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jun 6, 2019 at 1:17 PM Yu-cheng Yu <yu-cheng.yu@intel.com> wrote:
>
> From: "H.J. Lu" <hjl.tools@gmail.com>
>
> Add ENDBR32 to __kernel_vsyscall entry point.
>

Acked-by: Andy Lutomirski <luto@kernel.org>

However, you forgot your own Signed-off-by.

> Signed-off-by: H.J. Lu <hjl.tools@gmail.com>


--Andy
