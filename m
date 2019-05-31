Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AECFB30696
	for <lists+linux-arch@lfdr.de>; Fri, 31 May 2019 04:24:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726509AbfEaCYs (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 30 May 2019 22:24:48 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38750 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbfEaCYs (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 30 May 2019 22:24:48 -0400
Received: by mail-pf1-f194.google.com with SMTP id a186so4468317pfa.5
        for <linux-arch@vger.kernel.org>; Thu, 30 May 2019 19:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:references:in-reply-to:mime-version:user-agent
         :message-id:content-transfer-encoding;
        bh=IT7tL4ec+mYJULv7CprD8eq307BhvxplP1hxReJnmGY=;
        b=JXxqi0AwqnyanwvX2sm45PLy+OW7/6yCN9kfD6O/qyWOHVeSGoIKgnnRgjTApwQ78+
         K6tw4gsGLKKKSCypzthPDlb9EtnFIGoGG35lMfef+u+kVV/qc0aVieqT6MBOJT7ghvir
         Xyxmvmelc5hmV7p1+WCp4Ioln7MpeLiqber3GyIarsifm4RJ9e0S5TAtopaiIPNWn5zG
         z1dbP2lQWii6QGP5b3nSkT/KyO0PiBACANBZkrBuRllSMAutzG+JdlYE8dbCCDNIUR9R
         7NGRlkgl7y64bb3kKKGH0Jd1yIILdvJsN2U4Ul/D9ywtf3BH7YulxXPMaMs/5yfk5uO9
         +q0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:references:in-reply-to
         :mime-version:user-agent:message-id:content-transfer-encoding;
        bh=IT7tL4ec+mYJULv7CprD8eq307BhvxplP1hxReJnmGY=;
        b=SfzgE6v6rJZYL1dwRmAOASjKSCbfcMZzd3jf6XrzFgx+KTsYBlZ6XoQ22cnEJ8Zc/k
         ejcKb5x06q1hzmX3BL9BQDH4ow9R2zgZEv1G1WXGJ9p0OZ8miyczyAxxBXxr4FH7J9UP
         Gh8zwN0UOhN2A9v2qGee2Qo4mpZw6+Q4Wg9KK423EUfLgImByw68zsZrCnpi6ECELxn8
         5Cg6iW8mUDn2sD6C78/kBxVD6+wqS4yGvep7xG80jcE+kHaDHKOC+Drga5fkityHmhSZ
         YzgD5PdsCj/Dhtlw9drGiXPXeNAldt7OUjZHuIugbL+iw9kBhYTlwkN6u8b1vp4mna2K
         wc7w==
X-Gm-Message-State: APjAAAW5ksjgnJTiw/dQXxmv9utNnmokMLfS//mc3eDTn9rZio5a5m2l
        /WYglIpTQk05yuFMXrtvmPJKyMlQrkg=
X-Google-Smtp-Source: APXvYqylwF2vBW4G23aaB7l8Kfyn367nP02thZAoCMuzMFg+RuqO583xQ2eA6Z9hVgwEqmWGvf5aLw==
X-Received: by 2002:a63:480f:: with SMTP id v15mr6452422pga.373.1559269488063;
        Thu, 30 May 2019 19:24:48 -0700 (PDT)
Received: from localhost (193-116-81-133.tpgi.com.au. [193.116.81.133])
        by smtp.gmail.com with ESMTPSA id b35sm3723852pjc.15.2019.05.30.19.24.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 30 May 2019 19:24:45 -0700 (PDT)
Date:   Fri, 31 May 2019 12:24:27 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [mmotm:master 124/234] mm/vmalloc.c:520:6: error: implicit
 declaration of function 'p4d_large'; did you mean 'p4d_page'?
To:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>, kbuild-all@01.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-arch@vger.kernel.org
References: <201905310708.EAdSCJKR%lkp@intel.com>
In-Reply-To: <201905310708.EAdSCJKR%lkp@intel.com>
MIME-Version: 1.0
User-Agent: astroid/0.14.0 (https://github.com/astroidmail/astroid)
Message-Id: <1559269231.3e5ttes2dd.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

kbuild test robot's on May 31, 2019 9:42 am:
> tree:   git://git.cmpxchg.org/linux-mmotm.git master
> head:   6f11685c34f638e200dd9e821491584ef5717d57
> commit: 91c106f5d623b94305af3fd91113de1cba768d73 [124/234] mm/vmalloc: hu=
gepage vmalloc mappings
> config: arm64-allyesconfig (attached as .config)
> compiler: aarch64-linux-gcc (GCC) 7.4.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbi=
n/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout 91c106f5d623b94305af3fd91113de1cba768d73
>         # save the attached .config to linux build tree
>         GCC_VERSION=3D7.4.0 make.cross ARCH=3Darm64=20
>=20
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
>=20
> All errors (new ones prefixed by >>):
>=20
>    mm/vmalloc.c: In function 'vmap_range':
>    mm/vmalloc.c:325:19: error: 'start' undeclared (first use in this func=
tion); did you mean 'stat'?
>      flush_cache_vmap(start, end);
>                       ^~~~~
>                       stat
>    mm/vmalloc.c:325:19: note: each undeclared identifier is reported only=
 once for each function it appears in
>    mm/vmalloc.c: In function 'vmalloc_to_page':
>>> mm/vmalloc.c:520:6: error: implicit declaration of function 'p4d_large'=
; did you mean 'p4d_page'? [-Werror=3Dimplicit-function-declaration]
>      if (p4d_large(*p4d))
>          ^~~~~~~~~
>          p4d_page

Hmm, okay p?d_large I guess is not quite the right thing to use here. It
almost is, but it's tied to userspace/thp options.

What would people prefer to do here? We could have architectures that
define HAVE_ARCH_HUGE_VMAP to also provide p?d_huge_kernel() tests for
their kernel page tables?

Thanks,
Nick

=
