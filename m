Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6345E1B2BBE
	for <lists+linux-arch@lfdr.de>; Tue, 21 Apr 2020 17:57:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726124AbgDUP47 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 21 Apr 2020 11:56:59 -0400
Received: from mga01.intel.com ([192.55.52.88]:6406 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725963AbgDUP46 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 21 Apr 2020 11:56:58 -0400
IronPort-SDR: PMoW7R1OL8gpQj2g+OHWnCVk4rjs6v7j4GRa/VDtZJl76aD7DJOFOMjTv6XxDA2odyxTAZNydD
 oWaBAae7MO+A==
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2020 08:56:55 -0700
IronPort-SDR: 1TLJ+VKzDLrLxqmaf03G9NyNcdj5ifaBj7PUEGjv4BtksyQwQ2knrIDE7Nm6LN3mxo+ZHj4PqB
 rH+XY3wRdAWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,410,1580803200"; 
   d="gz'50?scan'50,208,50";a="273566595"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 21 Apr 2020 08:56:52 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jQvGQ-0004QX-77; Tue, 21 Apr 2020 23:56:46 +0800
Date:   Tue, 21 Apr 2020 23:56:29 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Jessica Yu <jeyu@kernel.org>, linux-kbuild@vger.kernel.org,
        Borislav Petkov <bp@suse.de>,
        Leon Romanovsky <leonro@mellanox.com>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, linux-kbuild@vger.kernel.org,
        Borislav Petkov <bp@suse.de>,
        Leon Romanovsky <leonro@mellanox.com>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arch: split MODULE_ARCH_VERMAGIC definitions out to
 <asm/vermagic.h>
Message-ID: <202004212303.QGojecQx%lkp@intel.com>
References: <20200419222804.483191-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="MGYHOYXEY6WxJCY8"
Content-Disposition: inline
In-Reply-To: <20200419222804.483191-1-masahiroy@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--MGYHOYXEY6WxJCY8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Masahiro,

I love your patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v5.7-rc2 next-20200421]
[cannot apply to arm/for-next arm64/for-next/core ia64/next powerpc/next jeyu/modules-next arc/for-next tip/x86/core]
[if your patch is applied to the wrong git tree, please drop us a note to help
improve the system. BTW, we also suggest to use '--base' option to specify the
base tree in git format-patch, please see https://stackoverflow.com/a/37406982]

url:    https://github.com/0day-ci/linux/commits/Masahiro-Yamada/arch-split-MODULE_ARCH_VERMAGIC-definitions-out-to-asm-vermagic-h/20200421-194238
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git ae83d0b416db002fe95601e7f97f64b59514d936
config: nios2-3c120_defconfig (attached as .config)
compiler: nios2-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day GCC_VERSION=9.3.0 make.cross ARCH=nios2 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kbuild test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/linux/vermagic.h:6,
                    from net/ethtool/ioctl.c:20:
>> ./arch/nios2/include/generated/asm/vermagic.h:1:10: fatal error: asm-generic/vermagic.h: No such file or directory
       1 | #include <asm-generic/vermagic.h>
         |          ^~~~~~~~~~~~~~~~~~~~~~~~
   compilation terminated.

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--MGYHOYXEY6WxJCY8
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

H4sICBoSn14AAy5jb25maWcAnFzfk+Omk3/PX6FKqr6VPGxie3azs3c1DwghmVgSWkD+sS8q
x6PNujJrz9meJPvfX4MkCyTw5C6V3bXpBhpouj/dgH/47ocAvVyOX7eX/W779PQt+KM+1Kft
pX4MPu+f6v8OIhbkTAYkovJnYE73h5d/fjnsj+dZ8O7n9z9P3px2s2BRnw71U4CPh8/7P16g
+v54+O6H7+D/H6Dw6zO0dPqvQNd686RaePPHbhf8mGD8U/Dh57ufJ8CJWR7TpMK4oqICysO3
rgi+VEvCBWX5w4fJ3WTSEdLoWj67ezvR/13bSVGeXMkTo/k5EhUSWZUwyfpODALNU5qTEWmF
eF5laBOSqsxpTiVFKf1Eop6R8o/VivEFlOihJ3oun4JzfXl57ocYcrYgecXySmSFURuarEi+
rBCHodGMyoe7mZrAVgqWFTQllSRCBvtzcDheVMPXuWAYpd1wv//eVVyh0hxxWFKYQIFSafBH
JEZlKqs5EzJHGXn4/sfD8VD/dGVAHM+rnFVihQzZxUYsaYFHBepfLFMov46jYIKuq+xjSUri
GAfmTIgqIxnjmwpJifDcrF0KktLQrHcloRJ01KToNYA1Cc4vv5+/nS/1134NEpITTrFesoKz
0FhukyTmbGWvb8QyRHNjoAXigiiSKabZRkTCMomFLXN9eAyOnwfSDSXAsHoLsiS5FJ1Kyf3X
+nR2jUhSvACdIiCy7MWDlZp/UrqTsdwUEAoL6INFFDsWoalFo5SYdXSpc+rnNJlXnAgQIgNd
cw51JHnXWcEJyQoJzedWd135kqVlLhHfOLtuuUbrjovyF7k9/xlcoN9gCzKcL9vLOdjudseX
w2V/+GMwdVChQhgz6IvmibFNRKQ0BBNQS6BLU8QhrVreOYWUSCyERFK4hyCoc8b+xRD0UDku
A+FSiHxTAc0UGL5WZA0r7zIhomE2q4uufiuS3VXfLl00H5zjo4s5QdFAL672SRmiGDYajeXD
9G2vFDSXC7BOMRny3DWjFrsv9eMLOJbgc729vJzqsy5uBXVQDVOacFYW7sVQRg/2NCypk4zn
BC8KBsIpfZeMEyebAL5I21vdlZtnI2IB1gE0GCNJIicTJylyK36YLqDyUrsN7q4cMiar8cL0
bo0VsGHBh1Ux48oewD8ZyrG1DYdsAj64lKcz9F3fRdx/aVSu/56Bi6FgyrnZkUiIzGCj6KZQ
mro7gSlr6X1z8Rzlja2yfExjjIxSrVOmA0zM/kkaw2Rx1+BCBCY+Lq0+S0nWg69VQa0GC2aP
oh8qTXKUxu5V02J7aNoZeGhiDl7T7RkpcwyKsqrklqlD0ZLCQNv5NWYOGg4R51QvWFu2UCyb
TJgj7soq9/JdyXo+lWpLurSUDbTGtfym++caoNhz0M1OFpIo0oisN654Onk78g4tYC3q0+fj
6ev2sKsD8ld9AOOKwH5gZV7BWZkG5V/W6ERZZs1aVdqhWGqogBySgAINVRQpCq29kJZukCNS
Fro2BtSHVeIJ6RCc3RpQY3CUKRVgt2CzMLeiiHkZx4AxCwQNwRoAeAQT5/G7LKaAkxOn67KR
7xVWUCZmY6CFRZmNS+crAqhCOtgBdoccLCYMFYyjhXUoKxiXgNKLDjC162b5iB4DTScTx2wC
YfZuMoBLdzbroBV3Mw/QzNVCMI4JSLauPgHQYRwc4sN0OlIww10BrXjaXpS+BcdnFVOdu6Aq
q78eT99UZwoGnHunr6dY7Ve9xx4m/0wnbVyk60X1X3vQ3Muprs2ZaGpFMgTEXRXzDWzgKHKv
e88qWKlGBE4mHe2vHEK9gAKsOZwvp5ddJ7vVho4kOAGTo0KWqU2cr5STqERZqAW1UKhBX3cM
Lgzb8UV06W8nBtTnaGPAhamKd8JXe+v4cvbQTjjeAhBxrBMuATxkoMsAFCpBpMKcho1oZ7kl
g8eFlbw3oluLrqLVjmk2YKHjJq4aN1KuRuVOx119Ph9PweXbcwM7jc3TOYTMQIo5V+BZDJcQ
tmmSZ8oGSt7vx/AIE9drczcdWaRHoZTJsJRNqQpPezjScurtdGvJWj6QAXy6UljvqhUI4HvX
12AJNIQCAoRWcQzrBJM4mdw3O6qfyBtTpgeNHv9SHuPxmgnoXXO0VIAr0hiL5WK0k6L68/bl
6XJVoQBWLNh27e3MjEs3rcH2VAcv5/pxuOMWhOckVYsH+y5RGYHWSNxP7OSJxW6z7pysgCVs
trpju07SYA6sBMn2tPuyv9Q7NWVvHutnqAKudawmc7Qkjd0AlcJkzpjhQ3W5StREGVJbqipz
rfzRgOVuFlKplrMynItuGadGc2qWEiTnhCvHAk4zGaeEIKaDaIAzSTD4yS6C7RpgUZlCTAyY
RWNLhXcMMJpIFIKrTQEmANSaDdBBI6SCgkanYKtAFBLHFFO1r0AjTYumsgUm6hgrU4LZ8s3v
W1CN4M/G3Tyfjp/3T0003GcvgK1dfbd3v9XMEAK8srbd4JTXVhiaGFZQw0SRKaw/GcyqOe6m
qHWwKUMuaNjylLmieys3ZKdVAb42jeYODNt2IGC+Zts8GLbj9ETLLVnpAUSYNztTCA38IBUC
vEcfuVY0U17KXbXMQR8jANlZyFI3i+Q06/gWCq+7IiKlbMZKQTAqsKCg5B9LiIttigpTQ2EF
W0axL5/XB7iSJJzK22GwAlWeKBg4Om+gk3VuYKPYVqHLtzddQLRY2ftND1qbbjRGQMX2dNlr
qyzBJ1i4E4SQVGoVaa2/S2FFxETPasTSMbWKey806LFJf7I+FWL6749gspskRUTQwPMZxMUm
tIP0jhDGH90JTau/PrXdYJSC5nqPgZ1qEqY2nYMoLf0WzVl3BRpCfJVNYltbzw75p969XLa/
P9X6tCPQod3FmKeQ5nEmlfk2FiCNVZrAUPGGSWBOCzs92BBgg7qSrKqRqNQnANfp8wlkgv5s
e9j+UX91OsgYQmoA/0ZeAgrAaURExwSZlbMvUnAxhdSTogHcW8sJ4auCXfU2UeugbMsg7usU
hyYQlw1qLUTmYO3OGTIQCerlOuB4eDv58OsVWBBQs4JobFktMisllRLU+HZ3ji5DzvJPxSBU
6Slh6bYdn7T3YdhJVPnxZlIUGlmMYuFu2ghXQ/Dnf5OyqEKS43mG+MK5q/wr38+W7JQ6ry9/
H09/gjMe6wes6oJIe1FVCQRJyLWiZU6NJJf6BmpurYUuG9buXYnHxaxjnulkjhvBg0ALsnHI
Q5txdt+KJpOIkbDGBOVXXM0ZoAruaqqoirywGoPvVTTH40IVBYxLOeKFFVGC2LSg7mxvQ0xU
KEKycu1WKBiPlteTL85hY7IF9aSmmx6WknqpMSvd/SoimvtpgCv8RFooc+FZLK0apj2GIomL
rthuqYwKvyppDo5Wr3AoKkyxkJy5AYPqHT4mt5zvlQeXITVONTur1dEfvt+9/L7ffW+3nkXv
fOAO1udXN6IroKZv4dSZMiANPLYPA55ivtExA9iarPDZI2COaSp9MKi4QQQFjbBHTqAJLN00
HnmQJuiOO2Mt3QnKdObpIeQ0Slypex3YacUQaLhZocjZ2DJFeXU/mU0/OskRwVDbLV+KZ54B
odS9duvZO3dTqHDj4mLOfN1TQoiS+91brw3Q8M09LOzB4bAYSGNVJ5kVJF+KFZXYbUCWQh1i
e1wfSKSTK949nRUeD6LGkgt3l3Ph9yuNpBAxeDnSO8BJArZAdYsrx/aprUHi6yosxaZSxz8G
SvyYDjx0cKnPl0HoreoXC5mQ3AkERjUHBNPpG/OBMo4i+xCoR0sody+7W8VQDOPjvm0bVwvs
3rkryknqi2dXNENul8jjBfXE0WqqPritAUY0dhNIMa98AWceu0dVCLCmqSfZqBxg7KalK1nm
oxxKB8wRTdnSiUyInEtAqt3m6LSmzd1Hp/1f3dlUJyDGyD4C7rNr+11bI2BXMNiDtyZbNCdp
4ZQENoDMiliYHrApqTKVYTKCCYnyCKVWAqzgTfMx5dkKAfLRN4664cT709e/Vaby6bh9rE+m
WPFKp3GGTqhV9WHFa3JPZ0NULsCKrK6CqwA+4nTp8W0tA1lyD75qGNT1q7YZiIUyWEK3Z1Ns
CCAb7pj1LSPHHF+PtSBGgN4pNjNgYDuVLTFDRM+qNsn1l3PwqNXEWuZsTlUrztk0qxj7hIHi
Yt/ZX5ILV04ok3ZmTUZ6GsZpyD5T8bw9nQfKrKoh/l7nODy9mOkcaR5TA4nF11KrSdAIncsf
NevIn3RSabFK+BhkR5XRaM565Wl7OD81Gfd0+83Oq0BPYbqAdRyI1eXLeh2XHqvmI1AvhceR
tzkh4sht1UTmraTnkXkuyCjiNf8EAVbjK0drzFH2C2fZL/HT9vwl2H3ZPwePV8tlLmVMh0v1
GwGE5dsuigG2zPXSnlUTGlM4xXWYYnCplEOIAHWsaCTn1dReqQF1dpP61qaq/unUUTZzlOUS
HOJajikoi8R4KykKWFnk2xJALiVNR3qP3P5Y0zzXAPQWDAXYbudGubG0TZ5q+/ysgEhbqE+s
NNd2p47JhptdRY8wEWpqVcxyQ+vmGwFMfnqK5Gi4XQblFZmaK2X10+c3u+Phst0f6scA2mxN
o6G6Vo8ivTW9xfwWFf7cImuDMVMiDHdWtD//+YYd3mAlvh8UqEYihpM753y8PtSBOchJDh7e
r0oQmA8ZtDRpoW4S/Kf5dxYUAA+/Ntksz5w2FVwyv96U3RLE7l555xtAPAOf2Pl5aUT8LDY3
FDiXMqfScwUbqCrdKjkhZgMVQTzduEkLFv5mFag0KKBkq8xKd8N3KwcG3zOA9lYBtED4Utlm
kg3EV5DTd6MQrLrndkN7yOI6wMnLNFVf/LUAyzEjeWaW6syvPqt8uB83jfmmkEzxuQOUli3i
of/gR4v4Ct23DXEEVk5FYzhauluAqF7PqILst7sIxzsjX2YkEC/Pz8fTxQoBobwahiJdmGfW
aYzt/rxzYT7Av9lGqY5TLpLjlImSq7snXGNON0bwTc1aXf1aVyKKiSdmWhYop24ang3VrDmM
IYVySOfxjDSU6sMdXv/qnJZB1eamfP3P9hxQfQHpq76od/4CUcNjcFH4TfEFT2D7gkeYwP2z
+mhe9/t/1G5uejxd6tM2iIsEBZ+7QOXx+PdBBSvBVw0jgx9P9f+87E+AJ+kM/9Td6aKHS/0U
ZDBp/wlO9ZN+g+OYjCVsGx+Yv9WEMZ14ztxO0tSlxiOqLEfrGHpZOu1QB74Zs5AKRzRSzzaG
jwCMKm5/5OjI2mduS+65QYt4QqTvMi+Yz1GclbfsloVjeeTLoerd5c1zJCXy3MgmH0v9aMif
n5LEBwoQVnlJX1rZR1qufRQVeHqi1xCi9TJym93Ek4EF+YTHGMC44JNgnhyKLN0CQnm11Cuj
3wR5ai99tjdPM5aPrAygp8tp//uL2hri7/1l9yVAxg0VC5W0uvlvqxj5G3V3RtrqtSR5xHiF
UoTVabR+1nTNXEAEhSopiLtKhj6ZNwBMEuhTLilyEzl2l5eccSsZ3pSAo7y/d95kNSqHnKEI
ILu1U966880hzpSSuROJYgNxY+a7Ttl3iFFEBk8SQNWct/nMSktqXio2Sfr42hp+QgCH0Ou6
uXd89mHiuQEcDeqM+ySf8Jxa6aimpMoLAaPJEUigMmXDyRq3lDCWpG41mZdoRaiTRO9n79Zr
N0mFoU5KhgBDpnZAucwi51sCsxrFnFi1FuL+/t20ypxvAgY1WTtRHqqAlXJScyT9NCI5y1nm
nrbcyj+AGqwT8n9bk/u7D9ZlcdAj5nxV11cpSC7UNXynRMpHqBd7ZpsfoaAioPjuDFD2qpAc
xiGQcHbI1QkNd5IEykSZW0e1Yp2EZIh4HTUJ+ehukqWIQzTE3eshMoGt7uD7h+l0/UpvDKt0
1NptdIXU2mM1KzOYzX8xjE3OCrBVVi55hat1mgxWY1x3SS0zA1+BAnH94C7buOKKfsrtaxpN
SbV6N/UYoSvD3WsWvMHuZuMtmkdr6lexlgeCPTnkuYIxytoMtpHTUoVdBtsqw+qOIfV11/BQ
GSIPAusarrJyXWUZBfD2bxjVdRGVbfIgMM08p4BrY+9MaB5QSgwmiXqwmmJZF9iVXijmm5SG
Rop/BSXWNV4I3CWnSaIODeabEYKBXgNV7k9NIcCtw6o9MYv8tBZO+BnW9/fvP/waehlgWd+v
1+tb9Pv3t+gtvLjZwNv7+6mXAVNADP4RtO7fS48AOdzqPyru7+5ns5t0ie+nfgF1C2/vb9N/
ff8K/cOQ3lJjuiZ6ga3bNbhIYQf4WtQYoFqv0MbLkgqFj6aT6RT7edbSI1QLJYZidcXTSeJt
tIETN8kaM/wLDulfkyu48HLk+mIj8kvy8WZ1ThTIX9yga/fsp4OLvjlM5Sb9REmmk7U7blOh
B3gHiv2dLyFeEYJ46a1vSMAyzbj6250SKjzvoFP7ypy2ZPPj+fLmvH+sg1KEXUZAc9X1o/px
kuNJU7oLEehx+3ypT66EyWoQADfJpoO+ZLvaq4sHP45vT/wUXI7AXQeXLx2Xw9CuPKF1k2IQ
Hu+gr+I5jv/7/Sii3LGL8qUFCeFrVQwyr20i6fnl4s3a0LwozTuU6qvyOZaLbkrjWGWQvbc2
GiZ1y8V3UabhaH4iY+E7ummYMgQ+bz1kup7APqlHVXv1xvbzdpDpbOsz9V7hphy/sc1tBrJ8
jR6WiWe6RwcxVs0F2YQMceMpUldSIbkIrRTalZIuFp7M9ZUlJyvJ3Dp45VEXtFRuy72IV7YW
6b/CJNkKrTznBz1Xmb8qOYOVdmcNrixr+Woroee2kaETtxVCqN/+uMGiH2l5Lts1DKzEcwE+
anhjy5Zk8ATAiNzo21GisrGA29Ojzh7TX1igtrChVEL9dIsVzagC9bcnn9LQAXcW+gH2oB5H
K7dl1tQ2OwU1bzABVWHrW81w/EobqAh9DKXmcOcjUUbGz3fb1J1rEvtkucNMNobly/a03Sl3
0h+sdN5SWghm6ZpsdSX+A+A7uTHC7ZQkCG+8he0p2Ozd9f1DGoHO6J8QaZ+stUfUp/32aXyV
Qs0PgBN91IjtBxgt6X72bjJSsvx4eKMJ56Zd7WUdPrRto0RcplQ6f/+j4bBfxhiF6kqRygA7
JBM0pp5EdMeBcb52XTFv6a2K/iaRSr3LkQAD+g1ZPJxVuFGvhF+V4Fbvuj0AEvptXv/WxsEU
ojJSP3DwMJ2+m+k3tH5efCOx3rK38KwQusYtTtijt8ixSKu0eK0RzUXzGKLs11ixStlAxFlF
NIGoK/XcN+u0oBieqlwvM1ibYlQxhznS9xM9pzJ5lQgPVFOn29Lz9FC/QQbtzd0OpO1cv3Ic
ntf11qT9VRq37yggomh+28Y9MfOV49c8ujCRLAfH/1Cy8P1EjH5Y4b8cKTH8KbxnwenGdyI5
NqVmn0p0mMZSSP3EZnzpswFYM+yySarY1aXJbnDfeVS7cEcrAubePefDE8xreOO46CiLYPd0
/N/Kjmy5bST3vl+h2qdMlSeT2I7H85AHiofVMS/z0JEXlSLLjiqx5ZLkrcl+/QJoUuwmgfbs
ixM10Af7QANoHOsf3PgBuPz46fpah3mTJBStLqKYAqKXhyGqrO7vyYYRjgN1fHhvvmQNx2MM
R6V+VfAGgTe5yiSr6dlHfjqyWVgsvakQ8oygaKfC0wcNx3AbMX/2JrNE4HvxESfx+O+YeWj7
n3GebmU5xrBRpRr37oWSe2oCvtNj0cc950OtsXv9edw+vD5THBSXSVmE4kASAg0F4ulL1nkn
rEnsC8adiJPgYRLezQE8UVeX5x+XOVoLsDNc+RgZQ/l8SDts4jZM8liwCcMBVFcXf/0pgsvk
0wd+73jj+acPHwZssV17UfrCDkBwhWaUFxef5suq9D3HLFV3yfyatypxLpupurmpYzFOEnC9
8neEgfK4oDLafH+/evm+XR842hEUyQDfgzLTEKiNu2EUa8P7/eppM/r2+vAAVDkYWg5FY3Y2
2Gra6ny1/vFz+/j9iLZ5fjDUPHQaQj/AwKxl2bwTsLMy9vzbGEM/OVBb4/U3ej7ZzPen0jjf
wHcPbbMmKhhqTqDQPOrwE32jgBVbgFxchOmNYIgAiJKEVWNHQ/KCTTd+ASfG/2WzRiYHKzCk
A2t4l2hWIA1h6fmF4HdK0FxycSFoKXAwBKxRuymCx2F8q/iTimAf6LUQ21ODgTFMHfCsvvEE
7kghEcRYco7qdAZl8EIOwoFwWNibLC2UoGZAlDAplxHvjUTgOJQIPYG/9hyhLehNmIyVwNQS
PCrkpm+A3VaZY12hZ9JuyAgL+bNnIKQIhpsInqpwVmaShSANb6FjCYgI+M4j968EL2qEffHG
wsWI0Gqm0omg2NXTkmK8FUnvhiixTwyMDBdcMDUszaa8qoPA2Y1yHvPEA1FK1nxplBgtIhzw
RQSkV+6jCPXGl1ug95Qs4rk7wsgwLKJjb9NTrXv/pYKvO8LgRg15qQqhOQidQHfgBMgLkYeV
Fy9SmWTmKLL6jgZi6KXATS6fMZD+JNdHBJeecn2GS2dL8DwM0VPK0YJob9hAwxjlWEF5TDh1
io+L8l6R5Cg846g2BR5TPoxl4hXVl2zh7KJSjgMDVKgMHeetmsBhlqegmqB4OnRyspBQXTNb
5iXPKhM5VCrJHCRprtJE/oavYZE5Z+DrIoDr3XEgSyBaZCPGC3F0jcd9j69WvcKxHicNq8Ep
nRSgIEtlE18tY1VVcbgMU7hjDQNGhDMRGbG4NX7guSVAqON84MxogE9B4CZ+0Gt7wORhGSk8
O37qVJ5//3XAjAjaw4/juNIspx7nfqim7Lw52rG/6cYLbgRBuFrkglEtVixQNenwvU8SQfAB
pqT/8NF+VjhrXwNbph1+aVa8Z6XSlC7lu4KQxgUy8ynGSJ/MgJ/DSHqMn1DI8rW6BT+5uji/
dnSBCJ+uHY3Sg/G3n9vnH+8+/kYrU9yMR809/Pp8DxjMNh+96yjEb4NhJfFcMjoieD++zWlI
1X77+Gip7wm/MfoZTnNrDUSRoeX+WrQmCcDbiD3vMg5lEgL9HYdeJQ7qJK693Z+f8/FnLCSM
OzWVor1ZmG00FsbKe/tCQbQOo6Oe6m6V083xYYtOGk3szNE7XJHjav+4OQ6X+DTzhQdM38Ah
kv1IL5HULhZeLvrHWGjalOCfNIeSKH8B2PNbS5EgPB8TGaixiqXpV/A3VWPJEbCofE0SWGiA
Cqlp39dIG+Un3riOjHBVnXiOHvSREkRTXW+JXvhAjysVCRZTGg32snDD9fo3pqSeB6rMJY+5
WpjJqSraIAHcRYVgtCEMUys5Q1M8DXIhLE1TLZF6hYrUKNclJnQZ9kil2r1CX9LNk+RghZLt
er877B6Oo8mvl83+9+no8XVzOFpKnpMXkRu16x7Yv+HDQbvwFcgxAmt7k8VBpErOctcn53t0
LrytDTvyNrwrxqTIPfOJUqdGaUK//qtJWPS0ex75pCcnrRfaBpmbEhualAHPVXcNNrZ4w/Vq
30b4jgyubIYRE9nXAV2p3L3uLVVyyzXgRaF9V62SodN8Zz6nqqtLXvPH9mW04al4nHH22SrD
ILodp2dFJSHgKF8B3aWHjnK4k95CNQgT9cRk2tGxCDZPu+PmZb9bcywGRvGo0IGQf05iKutG
X54Oj2x7eVK2h5Vv0appbHlURaL/2OADShjbu5KSrowy2DHfty+/jQ7IrzycIoGc2Ffv6efu
EYrLnc95M3FgXQ8aRA8nodoQqpW/+93qfr17kuqxcG17MM//iPabzQHY483obrdXd1Ijb6Hq
O/99MpcaGMAIePe6+glDE8fOws318pe2BoIqzzEQ8t+DNptKzWP81K/ZvcFVPslh/2gXdF3l
CerOoyIUfIDn6JUnyQeZoJNVwuWTz4YvEuh9TEEWhkaIxV3fIwotB/oMkZEly2rHGA7GrxTf
1+mBEa0MKpCUYoYbR4tWM3VSd8U0UXkcZujL2yz1UAyTjcHxpbbxX1tWWVFIDKSJF7gaQ9sK
lcyvk7u+RGuhJXDxxPAXRGVnc/ncW55fpwk+agt+3CYWfquIpY3Iw4HI2T49WzNtVEVFqS9F
9RBC0hXekMh7z/f73fbe8oNIgyJTvM1Ii25wiR7rYzS14unST52HqL3QJjN0Cl+j8TBnOSVE
MtTT1X8xapUqwya7muRbzjUZCZYJpcp4DWMZq0Q6Oji+wtdhoAQ+hxLb8Py0bQzbxPsC0q2X
3yKIUy9WAWZziUpXeG6gVufLfha9DnbhgF1KsCJUmE+olOBfZNBcBgEHIo50XDm6S1XsqBqd
yzUxjxi7e3FOKReW5xtOniHZoNnBzNsyHXhm2Yv+1DaHCSgRbqWNStC0qsJ8jT24OT6gbRjO
Q3rQAQwQliS5M3AId0rD5GjCkeeofVdnQmwBtLyMSnHvaLC4IJj0QYA1IViWDKNK2WLsx/iS
iXPd8uUaW6MHv2NIJgxUggeNOWeqzP66uvogjaoOogGo7YdvW0vuWflH5FV/hHP8C9eb0LsO
Zy/0PYW68vl1ANOKWYKWBrlGpi//w+b1fkeB1rsRt9cSiAO9cP9UdCsElSBgPwceFVKAcJAI
FZyQQXPABMVBEXLeHph/w4y82N45BgHGf+QJYD7vdGLRtBgPq3bCt5rNKNWJvLW9wAGLZNjE
CSL/NIloOkYzlkHDWieyrslsN7dtiZYgu2Qjp3JKIDCuo8jOhtDBUb+EBEwgMxqxrJNEymN6
amqO0VMcKG1iEMwfIce507hfLU9TXVY0SWW6fVR4iTCF5V3tlRPp1DruQIynMBcJYOLYCrkM
u0vnl07olQwtXJ3mjkSei3IqkkzH3iuGl0NLsxorTvv4tUCqZf+envd+X/R/N7d7Rxax9JLp
u8AImGm/A73p7SJVUnYijMje6W9aBofsnnX6YOOZCK79/k8Yhd0uDHTYHgJOGYrbea/Twson
Tb9PQ+02Lwb0FRbBVxIgCzyZhMn8mRCKuk4VtMjdCipbznRe6FPsWoMJbhw61q/77fEXp/y+
DRfCuQz9GpmlZZCEJYm5FQirkqm9xnUC2Z1KStOJV4BcGgbEX/lZvujyQlrGcH00SalbgVCN
OAnMmCPusH7Z6b7TM/ZCXCaf/406SYyrdfZr9bQ6w+haL9vns+3L5uywethAW9v7M/QXfMTJ
Pfv28vBvKx/k99X+fvNs58jQim4dUXD7vD1uVz+3/21z2Z+4TVXptF+DfNUE0nmfMl94nBog
Y1ZOEdfO/tEfUi9xJPNFnX9Eb4+ZxB9j7A0Y0Xj7bb+CPve71+P2uZ++aJDrpL2MVYUhn4uS
yaYOOzT1YfdEGMmtSf3LoMRhKkApQUSl4h4PVPAZzIvGXdu+6IDh8lUlyLOF/5HPzYD1qo8f
AimmOIBVVS85VzCAXZz3xnABjEAYR0IQyQYhVn44XlwzVTWEd51sULxi5gm2JhoDFkqCXokt
iwDexBtYD+pMiAFY+Px7vnYKcc8RsjX4Fhmjj9QvqxSOUlPaiepfMWMDS99KfDgw1TtN+kAz
iAymyEo8CvyL5MvoEIuhZYxkAxtxEqJ6zwjq1Vqi6CDggIvZs/vxUXgsP68ZFITi+5XZWSci
A9BDfV/Y81Fu4XeGYHITZ1a6YfztmvCUYpcOzyTcAomCLWORweJu2U983W2JKDD942Af6pRU
xg2BKanZsXRxYPvEySbs6x86pwKVvuzhEvhB7jP3T5vDI3fNNrnmkS/m2UMNR0Ni9rbyGx/B
GENzTcP4lIL5TxHjrlZh1fkAwi1eopg4aOHSkHQoerkeSiBmhQ8WqQdLIm4DnfcPEMKiwISB
JnMizlX7LPoC3Mvvx+3TZrT+vln/OBDqWpfvuZnVIfPhpHIxw8KUWMwEvb/8SWimbYtAJAmX
M69IP3/8cH5pb4986ZWogk0ETj/0AmrYE3z6JiE6xsDRR6dAIbeEHjiwH5SmD8TlxOvZWHUM
lIVCg4aLPLbchJvsgZRjchZ6t21eM17d8k8n2npObbZ/sPn2+viIXIARu9RSxKB5MIo1dmRY
e6ClSRHblKu3N4FFNPA3zw+Py775dO9B1zlYeyw6DalBdKkUFRit/r1hj06N2bwKnKpwXqHJ
tsCJ6QYRUc70Rs3kmUKLdSkiKDWTjb/AhnDlj8Bc7C4wsZY1UgOeg6bsixorTAN9cBztTfkz
0MwiPfMRL8qRNZ3j9taD1TS8UdrVp2IayGcji/lgMQYfOOnFJNZqRMQfZbuXw9koBs7+9UXv
+clKZ802VgKELWSc+/kJODi+LdRhp87RQKTzWV19Nv2qs4jSINY5jLKSE19o4HJSpxhktuQn
fnbH+hme4JQaRPcmPJ645kILjW2KTWvXW1tkIClTMZOEsJURmCb7a4czdxuG/cxiWmJAG5Hu
QL87gDhGDqhno6fX4+bvDfxnc1y/f//+t+EN0SX/dR0Nxhamv6HfbKSYlaFwcWgEzdLAMYXv
dKA1jxzEcrXMCt8sPafAhqow2vaQp2k3zUwP/g3O5/+YZKNtvJKAuC3rFC3hMSniwGm893m3
mpAJ57RJ+ny/Oq5GSLfXbXb4/iQp4WsbmvsGvHRRWnrTUaEQZ5pocboMMEA7yIhFzbw8WcdN
+KR+r34B84cR8mxVkDYI8mv+EgIAXviRvPqI8eYWISRUvYnQ8K4cMn6d2ZE1vv6XAdXS/Ekh
2+lqTP1ACJcqJYPibylKmDWcouft7nDO0SydIkFztyZL2q9gcvqVzoFGtNHf/WezXz1uLO1Z
nQpibrt3kAmmELhfNBfHImvVDItjX5RwH2LedB0VwtRdFnWKlJNWFmlG3wozvg0EIwF9VcAp
gRtKiKRBKJhGAa1bZQyxPppvN4EsMEm9vPvGmLzCAUdBGYScDI0fRSyyKoBbeelurEmZK8Jb
uVOgluaHT8I5pgJzzIyWOLUuUgjT0eCVvqDXJIRbwKgESwtCoO3N65AIrqVhJxx2reBwTxh1
3bd2MaFzrygEsZHg+DAdxRnvqUwYBezzCYXEcky45AxCUBXwr+16p986jsHUkYlZf3yJQpWk
etYzmLumP4ajMEExXTK4jxRw3LAKUrZma7vQW7BjtLIM32w3UpWLTwB6yyWZY72Bvfc92HbO
TpCNEchk24iIADCRVXES6YHqWuts/gcvxbhqjpYAAA==

--MGYHOYXEY6WxJCY8--
