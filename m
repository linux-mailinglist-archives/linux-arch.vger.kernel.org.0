Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9ECF420ED6
	for <lists+linux-arch@lfdr.de>; Thu, 16 May 2019 20:41:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727430AbfEPSlu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 16 May 2019 14:41:50 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:34717 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726974AbfEPSlt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 16 May 2019 14:41:49 -0400
Received: by mail-lj1-f196.google.com with SMTP id j24so4079331ljg.1
        for <linux-arch@vger.kernel.org>; Thu, 16 May 2019 11:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SBJxqqJ41Gj2UgLcLdw3cvX6XyzdcNuSspjRp/Do27A=;
        b=IYVxqddi8vfmX/QE4v+tde5humzCJklwvwqZXu9M3qJCiAmHqmMOnzrLlWroQ53WGR
         K6YlA59NgT3y5mQSHrTZ+tUnNn/Wecg7LzyQnZKLTFSyQ1eT8f5jAcwcx8ZiPHpxkI+p
         6TJFsF27a/dp8fmtWnWMiWJrVZnlyg16ZPTsc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SBJxqqJ41Gj2UgLcLdw3cvX6XyzdcNuSspjRp/Do27A=;
        b=hvA4SkE79CRU2iqeb8mlQ59O+4Fd3z2VI114PysehgoTNTKGY9PIjNkGqfccubOoQy
         4b3sXtIdumV3n/z4650eYEK9nOb/1NcIPPj09yr2VN78LMmVlaDhCXBVEIJ1aU3FYaDt
         /5BBuwC+oBNh4Ivbi2VUQTBF06m9cWCG8onByCLsN5A8y75aF9GHoSoK28GxYclcusHj
         4wEygEsrqo5cjON5+JUuBlfXZklLh7c+MJtV/tfGSZsFz4b2JIZIwzB732uxat2xVO0f
         QTE+awhGOYFq0SSoEU6mGi1ljFaKZwY5kMWnhtfjauT69e3niClTJki2HBZE7zEJBhlo
         mjyg==
X-Gm-Message-State: APjAAAWYaUREATrKl+Wk3t3vVDDamaIhh1U3kB6Uy+JOHgplKgF1Ug32
        iGbdkfbnTpHiovg3gspmzlokc74lETg=
X-Google-Smtp-Source: APXvYqy5p3H8sGAe/YcP4nCfRX//XOXRBAm+xPjJlYPZ37GHusy4eBYn30px7twKx7uClrFfvm/3Hg==
X-Received: by 2002:a2e:380c:: with SMTP id f12mr8867027lja.53.1558032107291;
        Thu, 16 May 2019 11:41:47 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id c25sm1002991ljb.20.2019.05.16.11.41.46
        for <linux-arch@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 May 2019 11:41:46 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id n134so3398719lfn.11
        for <linux-arch@vger.kernel.org>; Thu, 16 May 2019 11:41:46 -0700 (PDT)
X-Received: by 2002:a19:ca02:: with SMTP id a2mr24597189lfg.88.1558032105763;
 Thu, 16 May 2019 11:41:45 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8P3a2+RHAReOZdo8nEvqDeC1EPj83L2Ug4JuVRiUh943AuNw@mail.gmail.com>
In-Reply-To: <CAK8P3a2+RHAReOZdo8nEvqDeC1EPj83L2Ug4JuVRiUh943AuNw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 16 May 2019 11:41:29 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgiv5ftb+dq7N8cN4n2YX3VkyzeQccywn07Xu9xhOLTSw@mail.gmail.com>
Message-ID: <CAHk-=wgiv5ftb+dq7N8cN4n2YX3VkyzeQccywn07Xu9xhOLTSw@mail.gmail.com>
Subject: Re: [GIT PULL] asm-generic: kill <asm/segment.h> and improve nommu
 generic uaccess helpers
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, May 16, 2019 at 5:09 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git
> tags/asm-generic-nommu

Interesting. I haven't seen this error before:

  # gpg: Signature made Tue 23 Apr 2019 12:54:49 PM PDT
  # gpg:                using RSA key 60AB47FFC9095227
  # gpg: bad data signature from key 60AB47FFC9095227: Wrong key usage
(0x00, 0x4)
  # gpg: Can't check signature: Wrong key usage

I think it means that you signed it with a key that was marked for
encryption only or something like that.

But gpg being the wonderful self-explanatory great UX that it is, I
have no effin clue what it really means.

Looking at the git history, it turns out this has happened a before
from you, and in fact goes back to pull requests from 2012.

Either I just didn't notice - which sounds unlikely for something that
has been going on for 7+ years - or the actual check and error is new
to gpg, and I only notice it this merge window because I've upgraded
to F30.

          Linus
