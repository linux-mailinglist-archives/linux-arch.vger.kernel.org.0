Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D2533D8061
	for <lists+linux-arch@lfdr.de>; Tue, 27 Jul 2021 23:02:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232471AbhG0VC4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 27 Jul 2021 17:02:56 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:60325 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232456AbhG0VC2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 27 Jul 2021 17:02:28 -0400
Received: from mail-wr1-f54.google.com ([209.85.221.54]) by
 mrelayeu.kundenserver.de (mreue012 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MrOq7-1mwtSX3Ahz-00oXnv for <linux-arch@vger.kernel.org>; Tue, 27 Jul 2021
 23:02:26 +0200
Received: by mail-wr1-f54.google.com with SMTP id e2so16730542wrq.6
        for <linux-arch@vger.kernel.org>; Tue, 27 Jul 2021 14:02:26 -0700 (PDT)
X-Gm-Message-State: AOAM532P8EPETsuu21uHSfGHMydvqjzA/utJy5GP+hdswEr5dZFC3QsS
        Ye/be9R5mq/m3jvRvyqLKQoIcBWKawPe1ou+358=
X-Google-Smtp-Source: ABdhPJyhZY+p6Bwnl2AuFwzcWetN6D4/ApK/TKrNY0tJ6UlXMhrHKgAG/bk24aRBZDD4El3dh4iT4w0SwHT9ZBj+t8c=
X-Received: by 2002:adf:fd90:: with SMTP id d16mr3017648wrr.105.1627419746403;
 Tue, 27 Jul 2021 14:02:26 -0700 (PDT)
MIME-Version: 1.0
References: <202107280408.RxUr38St-lkp@intel.com>
In-Reply-To: <202107280408.RxUr38St-lkp@intel.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 27 Jul 2021 23:02:10 +0200
X-Gmail-Original-Message-ID: <CAK8P3a27oMWeKz+kGr1fkZ+bmrOxXX_+az5yKr_qPxbfBkG96Q@mail.gmail.com>
Message-ID: <CAK8P3a27oMWeKz+kGr1fkZ+bmrOxXX_+az5yKr_qPxbfBkG96Q@mail.gmail.com>
Subject: Re: [asm-generic:asm-generic-uaccess-6 6/10] ERROR: modpost:
 "__copy_tofrom_user" [net/bridge/bridge.ko] undefined!
To:     kernel test robot <lkp@intel.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, kbuild-all@lists.01.org,
        linux-arch <linux-arch@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:88mZXfdxuCp7p5BvnV0EIGiJQUe6K1w7ygxVDqvmQa/PPR2p0gO
 DcnJjFzSoGkF1WRrwA9QIlYV7r9yQqlACKaODSSnbwXwerNm1mRR7EnGvFnOv7n/ZN1bB2A
 NJjm2j0gR1uNQRcNq4AW0snAv4fi215i7UaxV36rBAgK6ysoP+3fDQWswU/7+XqJScf6Nkq
 jjkOSqTJIlY81fC4e/b1Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:5Y0+5PLNVpc=:qHNGclUlRp4b/CJ/BUk2Cn
 QUMMzkxsH+a2R9QFZBaT7txn+/JMuQutlCyQ6i1SjomiCR9Q1uprH4/mhmpXI8qSbhJ5AkFmf
 7PpuIK5y6gfv4lLhErkILLbtX5YQ4lT5Euvr2n/BtB/GPHnDS8c70G4Iyy8TeorqtjWjSuGZH
 PPgV/ZT9W3j/n9+nyNhQC6TcQXcFhbtN0HM6wS9THeU/F7NuA/vQNLufSRVZATVqD7uby6ITG
 gLXDlPcs4Zd8R3hYgJigg5la3JTawX83HXV7w2pX9LOQd8UIcVCL1LKONuz/WhVLTseg7makx
 xScehMzxO9pUQh2trMcmBDUdqYkXKEZSNkYJiewesERnrqpONFAysa3U2hEC33k355v1nULSl
 DPqhk0+biGsKZE3nXLM7ZsfxskcVsj3iHkYjEVLVVqm3QFlzL/b2A4ArFvAqMPaP5aRGwEBE1
 9q4/uavcYeemEh+y2zi37rgONFeiAvYoJhNp7Ehjbwl97IOvrpZK9/CqmC+4ibOr9qQMVsHr+
 dMqlzNDZkvmm0cbskH3KYhgJbGq7MXI2/Cm5jDJCtS8zXpw8HuP1PQ3x2k/NQz4l3x2JAkxuq
 abH1701NG0QAI+rvwQ8PPt8lSz8T3Gv9vFYIEeWR/Igo53MInDEjWfWvXpYhDVthXI6c+wp5b
 wCrNiuJyf0Qmplv4+bLHa3+/sJq9jc12yfrolZoDKOLpA0e8s7t8cM0QCXHLK4hQE+JO6b6DY
 bT/4/N6eoPJ8C0grd3Hlu0E+Qgyymmp8Z6r5ka5FFmJGywUsc+b/5w5t/o/gKiTKOfFB2i5hE
 7yndpoGTR02LZa5TOCUKgwvaCDVJgsEEeIyxekH/gQwNP5qAFunCb8Z3HGapXinZnfhg97nyS
 4IBgTg7uktOyW6m8H6LNzdZ+BlhdlNeJ5X/rdYYt5EE1LrIBJJXRweLCrm8TgnUefFDMQihes
 tV3IIkCZI0MXX40HUg8ZUoaZBxs8v5glsm4k4l89vnO0o8wI13J3f
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jul 27, 2021 at 10:27 PM kernel test robot <lkp@intel.com> wrote:
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git asm-generic-uaccess-6
> head:   725a40b8ebf55a6b95e11a6b35717a99afc8ac98
> commit: 8ea805cb5e3294c8890c4781f82c03d6cc417bf5 [6/10] microblaze: use generic strncpy/strnlen from_user
> config: microblaze-mmu_defconfig (attached as .config)
> compiler: microblaze-linux-gcc (GCC) 10.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git/commit/?id=8ea805cb5e3294c8890c4781f82c03d6cc417bf5
>         git remote add asm-generic https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git
>         git fetch --no-tags asm-generic asm-generic-uaccess-6
>         git checkout 8ea805cb5e3294c8890c4781f82c03d6cc417bf5
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-10.3.0 make.cross ARCH=microblaze
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>, old ones prefixed by <<):
>
> >> ERROR: modpost: "__copy_tofrom_user" [net/bridge/bridge.ko] undefined!

Ah, I removed the wrong export, fixed now.

        Arnd
