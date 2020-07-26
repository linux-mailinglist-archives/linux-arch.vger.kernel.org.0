Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CACD22DD6C
	for <lists+linux-arch@lfdr.de>; Sun, 26 Jul 2020 11:00:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725937AbgGZJAy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 26 Jul 2020 05:00:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725794AbgGZJAy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 26 Jul 2020 05:00:54 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6F6CC0619D2;
        Sun, 26 Jul 2020 02:00:53 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id u185so7515548pfu.1;
        Sun, 26 Jul 2020 02:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mlBhtj6mj7rzh73CGqPbaedBqXAiRs4Xc3u8F8OgDvM=;
        b=cDJ6nW6KkxctO85wMzE88+C988ifH29e1rhCCwzz7kstStSjsmycqBQVOaFBBCpo0Q
         yElh4SlW8tKaHiKeEt8AhtYucLQUXQDkYZyY5sNjslVM4XbSaBvjzorcvis58TSPcOeQ
         hC72TPZUo2ZArEQ8UxqgD+x0UBLsF9dc3046xKtrxM0eAEYN0gfh9bQb7fN9y3PUHijr
         lJ2wmIt5Z77mu0W8+Yye+U5kmuQXlNx2cpWEOiV9VbDjwwiB+Qe9KWbr9gMj6O97sdtk
         oRZpH46jG3z87kqYu0CL5WIry32P6bN2ryCUYZgS5VvODC86VyQIUGX1s31LW8FJpXfA
         4Jqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mlBhtj6mj7rzh73CGqPbaedBqXAiRs4Xc3u8F8OgDvM=;
        b=rzYwMSw3y6rr7gmEvg6kk5e0mbKfRPfeejCCe4WnjJ8EuaYA55j3gSyDolvUiZ3Eh2
         +vAGpYnvW5XBn2FfMkDGUMgAOLfNedU0w3qmcgDSl+uvheq9LP5E1N4iz1NTsQumgveQ
         uXk4DYZRPN9Jy/TSo95Aw+xpQMyxqvOs0f1P0aTucqhy/oZvp0r6gB/rA3nnjwv4QdxY
         yc93C0rouljFjaXK7kX52RaYA3fL7O9TYm3gYyy+YqTBxKzovE04qk+nP73gk28iharM
         X0Nyn1qhxkf32c6Ozbd8AZpmVwrOUvKpBQdmOFNyZ5QiKpTtcIO85DT1Aqa168TS9E35
         qiAA==
X-Gm-Message-State: AOAM532TBUo1V/MBGYPLoTzBlUiKw7WQOW+MkvkQKqCB4+ioq1YdMVlp
        tX7I6xyDnJ/cqgau6zWpQNdkvr+/0HEGxvJ9e0c=
X-Google-Smtp-Source: ABdhPJzULnqz0fnaSJj9PJcaLQmORbUoT0kT60oObYuQPvv6MHdXLYTHgkOy+hcZym4uhmRbHXjwaptbpPmkpPFS/0w=
X-Received: by 2002:a62:7b4e:: with SMTP id w75mr2631394pfc.130.1595754053508;
 Sun, 26 Jul 2020 02:00:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200726031154.1012044-1-shorne@gmail.com>
In-Reply-To: <20200726031154.1012044-1-shorne@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 26 Jul 2020 12:00:37 +0300
Message-ID: <CAHp75VciC+gqkCZ9voNKHU3hrtiOVzeWBu9_YEagpCGdTME2yg@mail.gmail.com>
Subject: Re: [PATCH] io: Fix return type of _inb and _inl
To:     Stafford Horne <shorne@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Wei Xu <xuwei5@hisilicon.com>,
        John Garry <john.garry@huawei.com>,
        Linux-Arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Jul 26, 2020 at 6:14 AM Stafford Horne <shorne@gmail.com> wrote:
>
> The return type of functions _inb, _inw and _inl are all u16 which looks
> wrong.  This patch makes them u8, u16 and u32 respectively.
>
> The original commit text for these does not indicate that these should
> be all forced to u16.

Is it in alight with all architectures? that support this interface natively?

(Return value is arch-dependent AFAIU, so it might actually return
16-bit for byte read, but I agree that this is weird for 32-bit value.
I think you have elaborate more in the commit message)

-- 
With Best Regards,
Andy Shevchenko
