Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2DB030C087
	for <lists+linux-arch@lfdr.de>; Tue,  2 Feb 2021 15:02:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233283AbhBBOA2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 2 Feb 2021 09:00:28 -0500
Received: from mga01.intel.com ([192.55.52.88]:26720 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233492AbhBBN6M (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 2 Feb 2021 08:58:12 -0500
IronPort-SDR: lBSrtWBYb2XmFCnvnWR7wxzriAoQQFBAEUhzrYNkRXTQyu2ti+7AoqDHWGRIk9UdrqFHEyJZCc
 aFtj7QClU0Bg==
X-IronPort-AV: E=McAfee;i="6000,8403,9882"; a="199774295"
X-IronPort-AV: E=Sophos;i="5.79,395,1602572400"; 
   d="gz'50?scan'50,208,50";a="199774295"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2021 05:48:54 -0800
IronPort-SDR: WI7fgyyQzfqL66YK5ke3MM3QxiZ1D3mJq+6rPIlOjAPl+yVBSYKJvnaWuDc4S2oAJIowaszFp+
 vTUzsRZujSXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,395,1602572400"; 
   d="gz'50?scan'50,208,50";a="507331081"
Received: from lkp-server02.sh.intel.com (HELO 625d3a354f04) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 02 Feb 2021 05:48:51 -0800
Received: from kbuild by 625d3a354f04 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1l6w30-0009OP-H4; Tue, 02 Feb 2021 13:48:50 +0000
Date:   Tue, 2 Feb 2021 21:48:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nicholas Piggin <npiggin@gmail.com>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     kbuild-all@lists.01.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Christoph Hellwig <hch@infradead.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v12 14/14] powerpc/64s/radix: Enable huge vmalloc mappings
Message-ID: <202102022131.EydoQ3Qc-lkp@intel.com>
References: <20210202110515.3575274-15-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="k+w/mQv8wyuph6w0"
Content-Disposition: inline
In-Reply-To: <20210202110515.3575274-15-npiggin@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Nicholas,

I love your patch! Yet something to improve:

[auto build test ERROR on powerpc/next]
[also build test ERROR on arm64/for-next/core v5.11-rc6]
[cannot apply to hnaz-linux-mm/master next-20210125]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Nicholas-Piggin/huge-vmalloc-mappings/20210202-190833
base:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git next
config: powerpc-mpc834x_mds_defconfig (attached as .config)
compiler: powerpc-linux-gcc (GCC) 9.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/ba7c3aca8bdba641f1cc3cd3da5c19da2b5f721a
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Nicholas-Piggin/huge-vmalloc-mappings/20210202-190833
        git checkout ba7c3aca8bdba641f1cc3cd3da5c19da2b5f721a
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=powerpc 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from arch/powerpc/include/asm/book3s/pgtable.h:8,
                    from arch/powerpc/include/asm/pgtable.h:18,
                    from include/linux/pgtable.h:6,
                    from arch/powerpc/include/asm/kup.h:50,
                    from arch/powerpc/include/asm/uaccess.h:9,
                    from include/linux/uaccess.h:11,
                    from arch/powerpc/kernel/module.c:13:
   arch/powerpc/kernel/module.c: In function 'module_alloc':
>> arch/powerpc/include/asm/book3s/32/pgtable.h:189:32: error: 'high_memory' undeclared (first use in this function)
     189 | #define VMALLOC_START ((((long)high_memory + VMALLOC_OFFSET) & ~(VMALLOC_OFFSET-1)))
         |                                ^~~~~~~~~~~
   arch/powerpc/kernel/module.c:92:24: note: in expansion of macro 'VMALLOC_START'
      92 |  unsigned long start = VMALLOC_START;
         |                        ^~~~~~~~~~~~~
   arch/powerpc/include/asm/book3s/32/pgtable.h:189:32: note: each undeclared identifier is reported only once for each function it appears in
     189 | #define VMALLOC_START ((((long)high_memory + VMALLOC_OFFSET) & ~(VMALLOC_OFFSET-1)))
         |                                ^~~~~~~~~~~
   arch/powerpc/kernel/module.c:92:24: note: in expansion of macro 'VMALLOC_START'
      92 |  unsigned long start = VMALLOC_START;
         |                        ^~~~~~~~~~~~~


vim +/high_memory +189 arch/powerpc/include/asm/book3s/32/pgtable.h

63b2bc619565ef Christophe Leroy 2019-02-21  188  
3dfcb315d81e66 Aneesh Kumar K.V 2015-12-01 @189  #define VMALLOC_START ((((long)high_memory + VMALLOC_OFFSET) & ~(VMALLOC_OFFSET-1)))
3d4247fcc938d0 Christophe Leroy 2020-01-14  190  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--k+w/mQv8wyuph6w0
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

H4sICNJPGWAAAy5jb25maWcAnDxdc9u2su/9FZr0pX1ojyzZTjx3/ACBoISKJBiAlGS/cBRZ
ST3HsXMluU3+/d0FSRGgFnLmdqZthF0sgMV+L5hff/l1wF4PL1/Xh8fN+unpx+DL9nm7Wx+2
D4PPj0/b/xlEapCpYiAiWfwJyMnj8+v3/3x7+Xe7+7YZXP15cfHn8I/dZjSYb3fP26cBf3n+
/PjlFSg8vjz/8usvXGWxnFacVwuhjVRZVYhVcfuuofDHE9L748tmM/htyvnvg5s/x38O3znT
pKkAcPujHZp2pG5vhuPhsAUk0XF8NL4c2n+OdBKWTY/gboozZ+isOWOmYiatpqpQ3coOQGaJ
zEQHkvpjtVR63o1MSplEhUxFVbBJIiqjdNFBi5kWLAIysYL/AIrBqcCuXwdTy/+nwX57eP3W
MXCi1VxkFfDPpLmzcCaLSmSLimk4jkxlcTseAZV2yyrNJaxeCFMMHveD55cDEj6eX3GWtAx4
944arljp8sAeqzIsKRz8GVuIai50JpJqei+d7bmQ5D5lNGR1H5rhrOzTP57QIe4esA9f3Z+D
wkIEdyIRszIpLI+d07bDM2WKjKXi9t1vzy/P29+PCGbJHBaYO7OQOT8ZwP/zInHPkisjV1X6
sRSlILe7ZAWfVSfw9rK1MqZKRar0XcWKgvGZS700IpETki4rQbsJivYymIY1LQbumCVJK6kg
9IP966f9j/1h+7WT1KnIhJbc6oSZqaWjuj1IlYiFSHwtilTKZOaPxUpzETVKI7Opw8ucaSMQ
yZ50+/wwePnc21h/dauUi+4sPTAH6Z/DvrLCEMBUmarMI1aIlgvF49ftbk8xopB8Dgor4KiO
6meqmt2jYqYqc68HBnNYQ0WSEzdRz5JRInqUHM2R01mlhbEH1MZlyMke2zm5FiLNCyBlrVkn
ic34QiVlVjB9R4pNg+XCLEt4Xv6nWO//OzjAuoM17GF/WB/2g/Vm8/L6fHh8/tJjEkyoGOcK
1qqv97jEQuqiB64yVsgFrSAoLfZ+O3QSb2Ii2L3iAhQGUAsSCa2yKVhh6MMb6Y83vP6Jw1sm
aV4ODCU02V0FMJcJ8LMSK5AOSkdNjexON+38Zkv+Ug635vUfaFbOZ6BtIEik30BPEIMSy7i4
vbjsxElmxRzcQyz6OOP61Gbz9/bh9Wm7G3zerg+vu+3eDjcbJaCOL5tqVeb0ZaAdBlsA90mC
+Uzwea5gc6gghdK09BjAi6zDs0vROHcmNuADQPY5WIGIRNIiYXcE3ybJHKYurEfRke/FNUuB
sFEl2DrH2+io51JhYAIDI2/E960w4LpUC1e935fe73tTRK7ETZQCtTsRji4QUjmombwXaJvR
bsH/UpZxz4j00Qz8IeRkIKiIMCLiKhIVmFdWCYxmUNV9M3kWkRLVqFI6n7EMnKfOPC9ce1/v
N6gZF3lhw1TNuGNsJ3nc/aiVsfudQjwgwb9qh95UFCkYkOrE0dQSdDIcwx49815HA0dj7qmY
G5A57lAkMTBGu9tm4B7j0luohAi897PKpUMlV95+5TRjSRy5Rgb25A5Yd+kOmBmEId1PJh3x
k6oqtefFWbSQsM2GJc5hgciEaS0tY7ugDZHuUlrV4Z5aQiQcb8nGb3FESIuNdTDI71aukNSE
8bmzLwrN3GW8x3wITT66G48E3JYdJbcGtEQUCWpfVkdQzapjZNI5In4xvDzxwU06lm93n192
X9fPm+1A/LN9BkfEwNZydEUQEtTuuqHTkScd209SbLe8SGtilXXEngybpJzUzHCSK8hUWAFp
ztw9m0nYhPJ5QMBHUzQam8AV6alog/Y+7SqGECaRBvwCaJ9KaZPvIc6YjiAapA2/mZVxDPlW
zmBNkBtIpMDbBIInFcvkJEBpmO1ngUflz/l45N19zq9P7z7fvWy2+/3LDiK+b99edocuvIAJ
aNznY1OdUKo+XH3/Tu8VgQHY5TAwfvmduBJn/evh2DFr7rjjm46Bd+5FRALyfj7CUVqTEDwO
gqeXfdDJLvydxRCAajE9HXX3FJsEVdjqUer7oi7RSjB0pQJ8JFjnvqXI+xeDY+fnMGIOOzsn
T8vKlHle1yW6qTiMHoqW7zQnxfVU4o5mIDJq7AQrGMtP8IqySDLHH49HE+l61LTsmds0ZXml
M4h+IBGtUra6vXh/DgGSyIsLGqG1NW8R8vA8epnGVMPcXl2MjsYG8u25DRoctrYO0w7DjDhh
U3MKx5QTQspTQCv+s6WA7K7w5M9xv0wndyeRQc6yJttVJQTgH44FrjrMVakswKpB4FzZyNgN
Xmo2sLtGUkDUI+7LfhlNptXF9dXV0JmFNQI79/QAnq13Bm2ojDrRbsLRsbbQUsoUzGnf+8qJ
0HXUh5GSkZOkj2JKk4OYhcGW2ZjPazURrnJP65qdLU+Y21FjVZ/WB/R8jlH1FI7PNJ0yIDDN
OchK2LoifHTG+uYp42HT3Jvpgsbfv7vqDet8GA+/Q8xPV4Is/OIN+Oh7lUa0gWjhvfku9NLO
PtkUDMtiFSZ6/cai17joPAx//8b89+FDM5Pj/ugKYipAai8C7G9OduJorwNX3YaAIThL5ZSp
jE5f5xByTctepbcjnbMcUjWmGdZUAvtVcZ36YTYKWYBf484lb4te6D7j3fZ/X7fPmx+D/Wb9
VBd1utwPzDyETB9Jb0HPbgnLh6ft4GH3+M92B0PH5XC4vwLWw4Ir1BOcEZewW+UJBAkiq3RB
K13Ky+Zqb0R6IrWtT+zbCzcuf/mG/REv/sb6HeQT5IKz++piOKQSg/tqZG2wizr2UXtUaDK3
QMZ3EDONtbme0RSZtYxNkXmmijxxLTuNo+FPC680MBcrQbOWa2ZmVVSmVPBiyYMPLYB2s4wj
n0kipixpHUm1YEkpurYOivfl3EbmvTjOButNmerozpsOzbF61fokrDj0cW19GiOJ6h50U0F+
oJ1YgaeRVaSupiNWoF8geJCYQCrXjTcOy0mUGg+Gyce9nwS3IDOXuc096RvvvCSl8SnkNqIX
bqa2AGbHaYeTVks2FxiyUKXBPO1Rs3ke3c34CHe1hJsScSy5xFyxcfnn8s9Wc47XblgVpaxi
toRhFWryuncUrBd0NPi+CEiIRrXgBcQ6TiEEI3qjuD9QY3hRfzLh5I7dfdiNsYd/MG9+ODb3
OsMeLbB8FtmKmco8zlq8aPt5/fpkB7CGvB+AaRmsW3obt+varjlY77aD1/32oWNCopaoOliJ
ux1+Hw/9LqlVBBXHRhQA3fSgTa8M4lxNgfPZnZGcdQjDHkJhq2H1ysfJR171WON3AEqWyPsT
Kfbapevd5u/Hw3aDVeM/HrbfgOz2+XAqBrV98es0NspVdULum6k6MiSl9y8wUVXCJiKh7ClS
7MS6zOAA0wyLyxx7Dj2DWRphG6uFzKqJ3z20hCTsFnMS2E3RA837sWs9qkVBA+pRbCPHvQKn
hcdlxm1ILbRWkONkfwneVGBdNLtrO38G2fJpYA9povXNjRUlCmdgMgsZ37X1bh/B5oIoiFX/
uNh7T1XU9Kb7p8MUvWJoFDEXa3jdGAYPr67LuUO2+OWn+N041gwbmuiYKGZ00uDlsNWUFTOY
XOcTaMZJMDZ43kCpnRRqj8+rJQP5wlzU8ovBbS1YAc4oPWE6bDVLZd2c4Wm+4rO+414KNseE
TGDRmPGPpdT0ctZpYuO1fTtAcMQIjvnzGVAF6ualnSdTThA799dAOINY5dTHuEvai0PVAVFW
7mo/NQ4/tXKL1ZYm0Zbs6+xpJ7KHAXLcsCMXXMbS8TMAKhNQUzQMWNPHJJmgL1aoJlndT8dd
E4pmp9vapic73WV4ZZNzNRcnpOlmZwvIFMB2OjN5AkFQhRXzJdORA1D4ckROT6KcZpz1LE1T
famNAbKS2v0Cd9g7OzVmkWvfCi6qcWV6uSI4BhcuIRLwcDq56wPPNRHQJVaF8sONTo1CrSm/
OlE3DVD9bT25jXGmXC3++LQG7z74bx0Yfdu9fH588prrx50gdlNxtnXpW6c7fI6Sx3B8eYXh
vnQNrz/YZU/H4YrfcXuXCYor/ZDAwYbgHj0m/KtV/iY2SjZcSdnv4Peq6G8EB+1ZQKdT7Ia5
btM20EyKPBv21NMrYdihJhNIFKOaOA1OmSE8OLkG02ln5/lCcKRjND8+3gp0wVrMQO+/AeOt
aXCh53BQKJdVKo2pn2Y0ffhKplZ86R5cBoYNdP4unaiERgE1S1u8eb/Z114N5iAuH9v2+sQE
Xn108NBLqK5DX4ipDslri4XpHn1ViNEkfrWrpJtAiLac0AUbhBmbETD6EhGhfogI6sL1XU4G
yPl6d3i0aUHx49vWiYRhW4W0wV6bfLi8ZBAiZx0OXY2SqzcwlInfooEVrbdwIKOQb+CkjL+F
YSJl3sBJovQNDDN9ayeQv+o3GWPKt5g7ZzoNMKYtI8TOVjwndWcW1x/eoO9IJ4XVFrF60vOL
I3vpRz9dxjGb/tevA1X3nMeROpgkVV1gwnccfonRAc7vJn7E1wImMV1U9Nc7Vgdq/TA5OAu0
rBDC148Ffbit9dTwczBy7hLMhAhNdoH+bN/LswICNF7pdElEJBnoqAKTnrA8RyvLogjNcmUt
rVOdOFaJ7AWI79vN62H96WlrX3IPbNf+4FzFRGZxWmCE6LSSktjPjfGXzXqO7RiMKJunYc7d
17QM1zL3+okNABwE1fVE6k1KdbzI0L7todLt15fdj0G6fl5/2X4lM/ymPujwBQaAh5EtSYKh
6OckMTNFNS3zHufnQuT2gYd/sSZPIB7NC3ujkAKY28vuNBCx8r422sxNC7znXre/lXo51cyP
fW1+AZHjpPSijLlJifntxdhoPZWZlY/by+HNdYuRCVCcHN+yQMoy9yp0HLK9zGZRpJWIIfkp
sCQRsCH0o+v7XCnaZ91PStph3tsYS1FC0lYV6jZnUwzxTEPUPrnAmsQ89OgTGIDnP3nSWcfT
ZV6/kn/ebh/2g8PL4O/1P9tBHX3HBoQTJfKBiK3zQtQpHPPC6rCkdrfilDfMfIJ1YZG1hQ27
q2x7+Pdl918IxU/lHERtLvzevR2pIskoMSsz6aQ7+AvU1ZMFO9af3YVkCRWErWLtqBr+gpBw
qm6/ekP2bdzXjpYdNOWkwiYTp4Msi1PrBi2bNRG4TWkKyQMPQwUma9RbTOmxX+b1Iz4OtsAT
rbwrzWoFyYGmSOVVnuUeMfhdRTN+Oojttby3Ao5rFuge4wlkLs8Bp2iiRVrS3VM8mt069ULq
DvIzpebSz2ZqsotCBheNFd01Q65WbBaGQXoQBsocTWjgsqxkug4Whgqet8M+pTLKw5JsMTRb
voGBUOArFoBoCcXV4Y9d9Z7Y+RGHlxO3xNMa7RZ++27z+ulx886nnkZXoRwN7uc60M2GmaGL
w4+UsHiWMk33ylucfHZniy6gX2kesqiAXJfm6PwkPwMEqYx4YJ/Y0eIFDdOBHn4BshNIHuiW
ajIKrDDRMpoGHypbwTCsry0wRBJbJCyrPgxHF/STz0hwmE3vL+GjUDaU0He3Gl3RpFhOZ7v5
TIWWl0II3PfVZdAG2HicPhanXn9EmcHn9wo/LfNCRLgiZrNQOofMRbYwS1lw2qwsDH6wEyg1
wD4hDp+HNT3NAxUIPGFm6CVnhhZqyxW700jQh0GMZAxBqMEWdQjroy7CC2Tc//LEAekVRox3
lf+Ae/LR+8oMX0j/JU+/2mlijcFhuz/0XnMg7XxeQCBGpl4nM3sAN3xxmMhSzSKpyINyRmet
gVoJi+HsOmQB4mrOqcB5KbHZYTzXx+Mpiv3FCXuOgGOA+GnbRoW2GZsybhGcXLcZwSAFQ8WZ
fSNQt0AdixbPZaBMh3y/CYTeTMY0QOSzKlTeyuLAKzLDsEAbjjFiGpYsizLLyBboVCvYS/2c
v0snmEwwk6WqGcWsgKyh1dhejsYbqW0D42j7z+MGwnP7mscJipsHi05Vov+j+cLQ+IPd5xgd
T7i0SRtoFLFdhDKTpx4ZO0K9NT/C7IMHwwKfr/loWB34KeTu85sgImQptBvEw6ekQUEItgDn
va8N5JknHZaVRRnwNgCUirZ4CMs1HW9aGDOS9jX2dHBHFUiifb0QuCyLE7gaC8PG6PkVforR
NaLQI/wP7T3qV1OIflqthbHNy/Nh9/KEn8E9HOXb40ZcwH8vAq+8EAG/TW7z5vBWV/j9wepk
D9F2//jleYmvR3A7/AX+YJw3r41xP4dW12pePsHuH58QvA2SOYNVH3v9sMVvTSy4Y82efIaL
p+IsEnBDVY5lH2REkEt/vR9dCAKlfTL45srHKil9a8cbFc8P314en/t7xUfw9rUaXXp1Jx5J
7f99PGz+/gkZMcsmFCn6L+0c+mFqLjHOdOA7R5bLngfvHuU8bhrzPFCnjx3L+tugmUjygJZA
bFSkeUzZXnCnWcQS5ZaOc11TjKVOl0zXD2qi1l3Ej7uv/6KkPr3Ape7cncRL26/r76JhUn/i
sfpj217YA/JKmMe9Y9Uo0nIRPJxFEAsdeF1UI2BBqiFT1Y8o6dwH0Zj9AK1Bts98zpTS7NOF
slAWz2sG0zd3fFb3YP2ud5VGYuiAT/16nrKLsWfyFOa8kWuJOkGMgqiChz6dmmahnmRBpeBR
4eTdKnYvSsVY9CoCfz0GQLF2XHhvcmCwLkSSoLma/OUNNLV6b8zrA8BvrxKl8LmHEXohoqou
Y7u7rdsAVD0LgPgMsq0rcDUTGhSi/6IDPyM5ftaRM33y/U89RCzQND2phmtWJgn+oEP2BikO
d0oRjLbbGDgzZPLj0YquZbXIZe+hdA+cKOVU3txRWx+3D3JuP5yStU1UhXhnV4/05PxZsjfg
ZvXhzO41S083j89s6n1fXFMwm1WMR++vnWPxSKsUEzceLegN4WtmFCmMvs/u+K0Ta7M6DSSy
RSo8l99nE8LJlAMAVT9VaXNKl2gdZzzuN5RhYtHV6GpVgYulQwCw2ukdKmOgNsKyIvBFaCHj
1Bp+unTCzc14ZC6HFyQYgpNEmRJcFGq5DP2dBbO8glyJvrU8MjeQWbJA6UKaZHQzHI7PAEd0
7GhEZpSGWBqQrq7O40xmF+/fn0exG70Z0ro8S/n1+IqucUXm4voDDTIg7cGIrg2oTv7Co65G
ZmPeykRx4AOEfJHjh3N0bj3q28a60yrAj6ZUQFpDQM1GdBmtgeOHC4EuSIORstX1h/d0ea9B
uRnzFV0RbhBkVFQfbma5MPSFNGhCQGZxSepe76AOYybvL4YnGlH//Tjb7+v9QD7vD7vXr/Zz
8f3fEFA9DA679fMe6QyeHp+3gwfQ4sdv+Ec3O/h/zD4Vw0SacSVHgeoQlqgZxpQ5XYQRfEar
Ifa0YTrHvwGD06mrRdGFWQUxZmzCMlYx+i+T8Uyb//4z8l6qw88TzhssFNaTTz8ERyC+4XKJ
aCYj/IujdODjXx74K2+ohTwfQ/OG9ij1ZzFh6xqXhnrmhPXqwcX45nLwG8Ts2yX8+zulkZAf
CKz70bQbYJUpc0ce9ewyztkYByuk8EsmG5BTWQxEfeAE0f47D2CkU6zKGjZ4EZfKolA3xvoz
EoJnmpahLE58tN9XBFIV22YTAZsL58QOB+1o8iBosQpBMEEJZDkTyOrKiI7MpoFeDuzPBOz8
/1F2bc1t40r6r7jOw9bZh9kRKVGiHimIkhATJE1QEuUXlcdxJq7jxCnH2cr8+0WDFwFUN+B9
iCtCfwBBoAk0Gn1R76X+JwtC61nv8Q6q8vNBz4yOtkbUPlDyVJ6RoQGq8VVQq4x5Vkvf81+/
ICCjbE/riWHNap3+e8XMB6sYmlcwZ65tzlOn6bVa2aassM4gB7UBpvj+UZ/KXYFaqhntJeuk
rFNmmRq2RdpxaDP6NJEGtqn9SaR1MA0wO2yzUpYwsMSyI+LJjLNCEt/mpWqd2gY9CUspAaHb
TGrpewmR3Jv2PhbJtsMU6zgIAlJAL4FrpqHnceoLz2ue4A+sGF4ObFFYyt+kzqg7yQwXdoGA
fyJAoQbRN5v7qqisK9i2RJ274hj1bzUqr6oiWY+YejXDxbMVE7AgEfa5eYMPBqO4o+bbIsel
cmgM/6rkSdapGMudZkXssG6/MKhErffNE3edToeK8gVLDnwvcNIuzaSO9XQZjLboXOP8MZDx
YRnI+PxcyAdM7W/2TAliVr/GnzBSRRvsWWy2TQXP+bBg4rvwiHDd8Npe/vQGu884Zvdi1upu
xS4PykJc4SL3+Xp8R3HdXir2WWr5tqzS0Nv39J7t7ACsbck5LyGWSq5WZ9H6b/haAmtVuHOz
GBO8aTciwfYQ7Xt7p6RGm7+guNmC9bcYaaL7OeNJvkmqcR3oIFnH6Oa2KLYZ/iHs9skx5SiJ
x2HUNDgpr00nQThsWcM59tC3KYTGYYvfuKnyA35LzBuqiiIQD5mRT8eXu0/Cw4IiqQ6pfekq
DvPZtGnI7U4cxlN2YfvbLd4/eXvy7I9C9SLJC+trEFkzO48NHi60iD6hKKo8Osmbo6c/nFWp
NS63Mo6jQNXFz6i38j6OZ1enTLzlYvwJq3dfqFH/QE2pFkCUq8Wpstzi4XcwISZkkyZZ7nlc
ntTdwy4LZVuEy9UynsahZ+vPIVTL2FciJNjp0KBGYHZzVZEXAl8dcrvvXK1S6f9vhYyny4m9
UYS3/hnOD3zNrV2rDZ88+qKuKxa3Vo8VHrXGNmp09sZpvuW5bUC6UwKu4jJ0YE8p3J1tuOeg
UKa5BL9VdHDvsmLLrV30LkvUuoGLUHcZKZKpNps0P1PkO9Sm0+zIHhRAwpIm7xho0aiATZXw
Tny1tl6tmk9mHs6uUjh5WOJBHEyXhH0lkOoCZ/sqDuZL38PUbCcSnZgKbPEqlCQToSQTy1RX
wmYzXuuRmqnpr28SikwdGdU/S4iQhJGTKj9vYLo8nCd5lthrBFuGkykW48mqZX0B6ueS2MgV
KVh6JlQKafFAWnJGGXwAdhkExPEBiDPfyigLptZFSMyADnOtF3/r9WoBMpd/6vZ2kPOkLE8i
JRwagT2IAEgsAQdTYu3nWCxHsxOnvCjVOcqSno/s3GTb0Vd6XbdOd/vaWhjbEk8tuwY/s1KJ
BGBTLVP83esMlXqNNg/2qq5+nqsdJ2KBAfUAQXpGLqzXzR75fW67kbQl52NEMdwAmPoO2+1t
i9l4d/8Cy2PGKceOFpM0nF5GO0yWqfmgMJv1mlC687JETd52p4yvDKecoyq5/NzwBvyodFF7
88j5jfrZ674RS5xE6Aq4nmPNc5rYqWxoQBPHi+V8RQJ6RQcNYCKaBbOJC7BQe6qLHs/iOHAC
Fo4GGGfJmn7F7gRO0tfJgbtekLMy20uSnDU1XRVOaefmmJzo6hI0AcEkCNgY0wvB7fmm45iL
bNwVK/mYbLw9ATjJWoz/AKKm52eQ6UlEGzssoXuSN+oJnxK1/dDTfOd8RCe7OOha3KDpSuRw
DgVsgTSxVufqBpeTQJerFjPO6IevSzh3hE56zeKAngPdwix20+cLD31J0g9qlZUyJendQrpV
a1lYwV+MkdWZ+9xeVhl3VVDYOqh2JcWmV8+M6lWjYBm6Jq9XCXGT1QIYRIDg1OKuMTuuPsIN
uQFojJp9BhdrxA0WQHh5N5sEltjbru+gaxC/Xt6ff7w8/R4t7f37n8W+aZ0HIcQJcYtmgwU4
sW6vHlcy6dhKFPXclGM/x8GY86qqUbMkclmMlI76abvXn+9//Hz+/HSzl6v+alOjnp4+d64O
QOmdPpLPDz/en5BQ48fMjO8Mvy53QKI9rGC02rqiUT8d5uaKGlFHYrtRYercTJJxHYBQe7Ux
Qhrp8cakSp0iLMm3AAsD9C3Kikth+1khjV6UZRgxVWd+ckxNpQ9CrhLb4cKiDQdLjCg5TpA1
Xl4T+PvT2jxPmiQtBqW5rYc/UvfKooHbMOqkj7qfXLZ8ucZbzQ/i6ivh33/8eieNK3he7m03
Yig4bzZg0ZlREXVaUJvS6lYQzNKCRAIxRsYg3bP9z6e3F0g79Az5GL48jIziuvoFRNYhvM9a
yKfi5AakBx999NkaA3flvjOqe5ueVgVlr2C8grv/4BaOX5G0EB1yj3B/bAHFnu2kksQIPXDX
k1FsC0PVw2e4UdTu4e2zNivnfxY3wDu2RTVoKZHlALHg1VDriioR6fVlYbdLYI8dLFswjm57
9fXh7eER1viLkWUvIdWWZHvAFFsQVWCp5Jv6ZHzircUbWdiZuobRYOuarbW11R7Mc5PBrl8+
vT0/vBi7pTGCSmjVhtrMvGjvCHFoBq43Co3MTn0oVhynY9+rM3aiikYJWUzYBvaCW2RUTBBr
7VDwB1n+ayYhbZIKp+TVeZ9UtRGZxKRWEI1QpAME7bcORYHnorFeT2bUm6+PuMxh9qQO45hQ
W7UwJVGCGw94XV19Q/nr9z+gGVWimUDLKYjFV9cUvO5Y42Aj7MA3RqExQeNWP0kiZ0xLlnxD
parrEYzlxPFjQARzLheEbrsDdYYnn+oE7LzwNc2G+mDduaCUXqRallzkqiQMeVuyDqBc+p6h
UTzfKAnbB2WgyIT4imu+5UwtF7hnz2jpuGomV3Ou/YyIXQjCRrcx9XeH8+oEtkWEVJKftwSX
5MV9QVxodZlElGCGa7AObQ4O10DoUHeES45auLuEIcShsVJrX8/3+N5XqjN9m7OMcHM8upIq
JWUJ1ld4PKPDyPFFldziHh86/qhtw3pEHK8u7Yz9XWqm/pV4H9UnkJ0ox6XrXdHsBLy3msO9
rHXEl2sPs1YYChkiPIaGPZb6cdaSEKQKtovb+KijMp2dyvLRgeJRaBiD0jrg9Ul+h04NggK4
Z1162J1Sb6SA8q/qpOhxRIRHqNNFEE1x0/WBPiecFXp646CL9SLCDd87MhjQkXQeE34amiiJ
oBNALDlvcLskoOb62hVf+jRd39Oet0SOKoBILqNoSY+cos+nuIq+Iy/nREwgRT5w3C67o5XV
tV+n5ledRfTmL/Dbayf85t/fFCe8/HPz9O2vp8+gI/izQ/2htujHr88//nvME+sUsgpqP01s
fyex6Elfc3jJxkxfwNZNnLRg9ljif7bk4sp91iATDtTpb7UsfFebi8L82X4rD52WhPhG6qSQ
6sB0LeQU719VrUs7xrCbJr/kNzt6Hco1XxMzKtJAOwvgkEr7PA0QiP7lgVBLqrkcGvWmhHhR
4junLIktdTd2Xxh28utwcGVd3jy+vD7+B3Uzr8tzEMVxmyv6evp1UJCb9jJJZwAmgyq9v6pq
TzdqkhWHfNaBNhXb6Af//B9zgq/7Y3SH56yu8GvFbckLKhjIEV/32tgT4INKeM73sSnKDLv0
2B3Hia2hoOefHaJxzB/eFUNjn8bgR7ZezAJ8qbUgsQcigkmIv7SNwZdcG4PvODZm6cdM/f0J
FgsfZhnOPJ5461qNz0cwvv4ozJwS6A2MzzNQYzzjLKe+ViRbzH0z2vDzJgGnXwgpThgeDO2V
KZXZs4fUTel+oFojZcIh1mZFGCqOgKXERYAet5Zzj7smuEt6hoFHt0oUwheCHrNZRNNFRDh/
9Zha1um+Tmpia+1x2ywKYvJwPGDCiQ+zmE9wOcVAuPlxx3fzgJCTeswnNnM3ola9Kgg98wAh
fxPKCrXH1Cxcztyc32IWpM+ihVt6+lSzWRC5mQMwYeDt0ywM3YOkMf53m4Vzf5/DubvPImmC
0L0wAmQ+mbv7o0GBe6XWmLl7dwHM0tufabDwcCJ4+vo+Zo2Zevs8n3uYWmM8bt4a86EX8zCi
YOXUt/3WbE4EHBxaqRZq0cBPgwP7COI4eQEsvAAPFwvPpqwAbn7JROz5CETs62Ts62Ts66Rv
8VCShQ/g6+QyCqfuOdWYmWeJ0hj3++a1Oknt0kpwSYWOGaCsXsQT97sBZjn2hB9jSm0j5d46
2CaOloSwLSgNXV9brmri3DIgdrXns1KIKZ5Q1EAwTxsOZUSPSQULZp6PU2HCwI+ZH0NCLzN0
SEg2W4jAw6GyruXCs/9JIeaebSJZsyCM17H3jCEXcejBqLeLfeJanoQT9wIPEA/nKcg09C65
CzeL1zvBPHtELcrA8zFpiHvWNcQ9dApChVUxIb5XFmUUuPty4Mk8nrsFz0Mdh57j2zGeLhZT
Skt/wcSB+9QBmOVHMOEHMO431xD3t6Ag2SKOiJC7NmpOmHjpdTrBAoceE4ifW2xtg4+2jFZA
DYi8OCanYo/dRA+Y9tqiTXXcppE10pENKAg8PORPnyCPkie5uVYdHR/eH79+fv37pnx7en/+
9vT66/1m+/q/T2/fX7V2wwbRlhCy2NTDs9B37q7onJh7ziuwFXCC+pCJTtD66KaDoAiue05Q
knGxCCbB+bgmDC/m08kklSsSEP/+/XtM7KMjdmnMhsFlD2+fx4ERS+bsoGoZ1zJLuTIzyV+m
SWKxrlcMkvcg8NUoZ0ZrZwgmhl9+fX/UmXZoE0CxgQyidazOj0RMFQDI6YLQ4vRk4hhXQgqa
ZF1GEXHO1fXBlu4MF7GMuNq7oHYZWxOWmQoD9ufLCbGFacB6GS0CccStjPRjmjKcNOQ5GSAC
bt7w0dLvu06WkyndByBHofMJGoKvmD2Z0FAMZHxJ7sgBsfsCeZvUKaiW5XlLGCHpMWABOMe5
x6kM54TCEsg7rg6TgR4yFKPkRx2kl+GvkkGSZeIuDWjUPRs8urXFLwW+HmjEnZwT4ROA/CnJ
789MFJTnMGBuU1FmRNo9RY7jUsSEO8yFTjOBps+JSGgtmzbBLCIOlR1gsaAUgReAg1daQExk
jRgAhHwwAOKZExAvJ86XiJeEen2gE8qGCx2XETW9nk8J3VJPdrWe5pswWAn6I6nSGtfVAlGd
8yL1KdOjU63ZNCT89DS9jiau6iyqI0InoOm3MSE+a2oe1XPi9AJ0mTKHzzoA+GwxbzwYERHi
uabenmLF5EQImVUTTa5jyNkNKMndQT1JRuX+U+Saq5PXdBo151oqgYee5KycLh08npXxIqbH
UT0mEw4mSTKREDY5pZwHk4gIrqSI0WRBM08LcHzdLYBQ+AyAMKC/D3g19fKO3bJDRMRh2niK
YwABEBOGCwNgGbg3ZQVS6zVxPKuP2WwydTCbAoDTtZsbj1kQLqZuTCamkeOTrtk0ipeOV70T
jWNKD03sEDyygu3yZJsQHikgPlX8vsgT50AeRTxzbHyKPA3ckgVAookPslziagi9dhU7oaTB
RRA7pMUepMQ1xyo4tOQAyRrEHMc6VovNqB99vEaXIH9pBKLxZQmlo6xcCzE4epwZREtrU0c6
UAiijc7+9vDj6/MjGkE/2WJhiA7bRPGK4RjbFeh8JlvIgRjMjYMiYqybqDIzRG83XmZxG6j9
7eHb081fv758eXrrzsbWCWizQscdrdYGLX94/M/L899f32/+60adRq5dNi5iKFufWZZI2Xm6
oSMLac0zbYFPQ/vI5p4nDyHXx9NhqgD2+fpqLHd8fW01qAotowu+hrxKdVqdIGd5mm+JgDoK
WCW4qfZ+xzH7b2i6iyM/mOH/eHoEY1qogBxboUYyAwtZqgvqVFsR6es0taSS02jqvqIiCuhh
SLNbjosFQGa7tKpw18iWzNUvB73YUysskEUCaWUc1fWnSpNPdAJuoKu52xZ5xQlPGICkQp43
eBAoTc5S6hyvyfej7IkWdZuKFSfsozV9Q9jWaWJWVLwgbj8AcOCHJCM9+OHIdtIOOjTgRA/L
MclqIsx7++z0KAsqLIzu/qlN2koCwLedfj4V+wBon5IVobEAan3kOWVq3g5LDrnYa0fXMqaN
uGh6mhcH/KzcMvWWM9r/qoVkEBzJQT9t1AJKz12VtrxNt6B914sNvgNqRAF+mA721U67bhbK
iRyYQINIqIR1PgdBPwcdt2Jy+vso0zrJTjm98JXgwMAcDWQJWDXlVPpTjam42qZJsky46zW6
qD00HSymMtJNARBk9OCOmmbgsECFwQfMPodADjSvUAaf8JmC814iHWusFElVfypOzkfU3PE9
qIVEUnZjmr4DR4A25x8J2sM+fC4lflgARMNzQXfiPq0K5yuAky1zfZPtxc15R9gI6602K0cP
6L1pEAng4k1gCSxDg9r/YJzVyzRoNqsNLoxG4eBhKFfnYsfU2ZPXdZZCFgBu+p4DvROGTRkJ
ivdZeZWbxiAPSZ53bD2qStRo3fVaT1wF0k5pF5FoKC+//vPz+VENWPbwD24WnhelbrBhKT+g
Y+Rox37JbbLeEsa89akk7NuhYlWo0XSk3hSUqkwJHaTvbZ4e1QZDpHFNGEvh0oRno8BFF65R
f3O+SnJMNk0Vi5/VwQoU+1KJlMaRRZMuXNCftWp2tkL+QIEW7e2iHasLecIL+8gY/3p7f5z8
ywRA7F7FmHatrnBU63L6q9l1xAODlnfOUZpXVIHt520AeV5v2itK+/m6vKwKhhSPfIfM8vOe
pzpoLH5mhV5Xh6u8G8MaAD1FuLyvl6xW0X1KLH4XUFrc41cUF0gTE1r2HrKWwdRWUSOAxWw8
DhcKeTVpwOYLXMvZQ3YnEVNOTz0GLlSpGHI9ppIRm3qexWUWhIRm2MYQ94IjEK6P6kGNguA6
qR6h7aFC97trDHUvZoGmHwF9BENo1ofZmAU1YbHXQ1Z3UyIkc4+Q02i6JOyZe8xGTClr5WHW
FZMTxvwGJIpxFZbZCnEX00NSMZ0QRrZDKwcFcTMXQKZu1qoOcUyYBw1jt1afbXy1uIAbkL24
mIsXOADmIKUOuzLgwSfnA4vSWk5DT78V54SUGbI1Qksim/dlMuaBPaWtUcPLw/uX17dvvq6q
4xi+oRprUkhokg1IRBgOmJDIPU06dVN03iSCE3oPA7kgDJQvkHBGWGAObFHfBos6cXOgmMW1
5+0BQnipmpDIvf8IKeah56VWdzPK9HTghjJixEVaDwGmci8B96f8Tly7W71+/4OVex9DuZLH
DkzXmg25V7Na/c+7WC2m9tsOek759P3n65u3s0W23nBCm7AGC5DDOM9am1xFJKv9ZshNbhpf
QTLNDSe0jm29MyTkVHJ6zTdEaLYWtksT4tQ0er4hBu+bNZflKNPjRTanYlbzqs8Xip1oOq9+
keZ7O5KoLqYyVPW1BPXQdYllkzjoHMRXz9KlVO6Eltpm1mkPcUhqtC7n3+Pb68/XL+83u39+
PL39cbj5+9fTz3frmDnk0HJDL4/fVum1u3/PEHWypRIvYezXV9tXm4RdvJztXPOFANdIRiTO
3B3VXpWjLqZMu4LK119vhKHYJT4kr+cz/NIEbcRoI+HZqkADB6h+742zlJXzVxNvyoe/n961
GyyS8tkHbY82T99e359+vL0+ol9+KooastHhSSKRym2jP779/BttrxSyZ3W8RaumwRdwRTNO
KNYKGqpv/5att3zx/YaBH/zNT9CTfBkS7A46geTby+vfqli+Msy/GyO311tvrw+fH1+/URVR
eut125R/bt6enn4+Pqihv3t943dXjXTveLfnjHVh3tHB8bWlG3v+H9FQ3byimY7U2fP7U0td
/Xp++QyxBvtRRDoLMX4aCGjde3xexSfpkxl+uHXd/N2vhxc1kORIo3STT9i5vs733jy/PH//
TQ18Z+B7YHv0DbDKg0LuQ9x3eVQp4JC/qVI8G2raQLY0StlTEBdonNgy8hpXMULaV2oBLo9I
FL7q7gbiSyBBVKq7cZYLiCI0Fmh6beO4HeMVIMkB2SntJU8wWiu/705qWfurDYdhTm2fiZsK
ywrqt2zrDN58vgXbDQWkw89CwIHeuLsuKkgI7cWtP9KYTDJCIQ4oiNbERROLu7Gm1IIJ3qSZ
+lty90PLJjmHcS4gggORtNVEwYig02xPhlEbLsMYEXBRMPwFKsKKSz19dsUGyffPb/9X2bEs
t40jf8U1p92qzEzieDyZQw4gCUqM+DJIWrIvLEXW2KrYkkuSazb79dsNkBRIdkPeSxyhGyBe
/QDQj93moWdpkQYqY26/W3RLlRSUIG7vAu2f3ZWf0aHnmCl1tdk+kqHRSib0iba4HVoMtDfw
4yZPNcN8Qt9uhJwTW5QxPkxxxPrG6QCrvskRTyLo8IEM3x94XBizkw1IArMvegz4VsRRIEoJ
3a91XE4qqhTAQJMRVnRV4JaXddjT9ZqieoH5VTkW+7kOKb0dIFfj5q50p7IiWtTCZ1LXNliF
9CvFXahrJO7G+ZsXXNrfxd8sMnwp8XzhT3seD0pGMG8AC+nF/MaDFjxoEhaXHMwrHZ9Lo9hR
NbzkawKEJkO5QEV4uECmrPZQga+znFpYPGCimd4s0nlROsU7DdA47G4It3sCXBiT1XMGCIAB
h0A6+UNYmDPr6YvBsCAyBcDMZD9zmnAcd2+qjEn1i+HFwuKKm1gDZqcdOsHBMJgvHJJrwg3L
X66eBrZjhd6b9FnIYBv04FeVJb8Ht4HmCwRbiIrsr+vrj1yvqiAcgdrv0G2b24is+D0U5e9y
gf+CpGa+nhSAyX37FupyMN0wSxclsQQty3T1zOg5h/Xbw+7i716PW/EKp7TafoXSBbN+uE1d
hhbcZTwozAUmzsrSCEjC3osaCEpeHChJpU6ZSZXaXx08hZVJ3qdYXXCGoRqcEQ8/acJhUPtK
gsTon/PxDz+9xOR1TWLUW2QDJg1or8OZEulE8oQjAgcs5GFScxYOOuUrAkgn3ODYsqOvnqM7
PMhXImFAxU0liilHJA7Bghk+Fyy/SRyjz3nYTbq4ckKveahyfTTHSAdMwJm74pblUI7pVmNe
3LKIJoxZfz+2QF2r//v2cvD7s71/TcmQ1mzg1RC9mDNaukGvqRxdCr180z6tIzqKlSbidJCS
w22QkJGAOhykg9EFUYGuw8Duc8q8BFAoE4WJDuyaY9xuy+kYhfzwpxm/9UFzX2hxtCpVuT/8
XU+KfjhqU8pnUfBlPmUpLOIAWSB45sJrXzGzIdMIWqSCM0dZPb/R42ltvW1dvYkCvnrbb44/
rYv8Tgb0s37hb1BIbyqJ98xjbaClKkzfAPs71ZHoFWhfDK0YJUxqW1QaBQB1MEVfcmMuyvnM
GwW9DhJZ6GuFUkXM2capzLdAkn510HgdITaFLqNu52f5XS1i2G5iIF1HaLRuhhmaQE8sskox
D0FFCeP2dTMJrLAJOEt0LpChqOLSmgphbe24SL7+gvfVD7t/th9+Ll+WH553y4fXzfbDYfn3
GtrZPHxAS5hH3Agfvr/+/YvZG7P1frt+vnha7h/WWzyznvaIeUhYv+z2Py82281xs3ze/HeJ
UDuTQ1TiEECFT7O0J9UnPugmcTWJUrSwr0BxkWKmx0kfWEh0705J2jjbgY8rxpyLobdZala0
m1HmiNAiYyJmFrd9Q6FnqQXzk3yKtj0g0XaCNQF1sYf9/c/X4+5itduvL3b7i6f18+t6f1oN
g4whRkVuRcXvFV+Oy6UIxqXFzI/yKRxvXhjAuMoUNAqycIyq0gnREbblWZ4T6BjheVxscsiO
+92U947rDWi4KcmKnTxDG66CaCWtYkpSW1Dq2/oPbRvbjrMqp8BJXSikWVn+9v15s/r1x/rn
xUrvm0f0pPlpH5Xa1Sjoc2kDDuiH4wYq/XNwFbjbLxL6tb+doUrdyss//iASUIm349N6e9ys
lsf1w4Xc6nGia9k/m+PThTgcdquNBgXL45IYuO8z6TQNeOIG+1OQkOLyY57Fd58+M1ZdHZFN
IjQxcc6DvBmasg6nciqALd2O5sHTT5Uvu4f+ib7tp+fcPP7QaWwAZu7jOjAlSrsOe0CHwyqx
oh2qGnAWUsbDDTCHwRBNLphgOy3/kHdzxajG7QLhc3pZORccTW/Hkz9dHp74uedyr7Xs8Qx8
cWbxbgf1zU3J5nF9OI7kgq/8z5c+yYN8xo6r7cViyjmjNBheLGby0rmRDIpznaAj5aePQUSL
/JYqz/XlPfSYBLTZVAc+U/sPTHDhRImAWPXzjRNNJcEZroAYTMyGE8YlE+H/hPGZsYZqec9U
0PZUFvzckAHnTD8A449Pzp0GGLT9XCcr3OAStDWPC+PUCMuJ4oLiNRjzfNBLQ9ib16fBA3TH
3J27GsA14yfVkQZmfHfval8kMo4ZR50OpyidGxcRnCsUuIcS6r/OFRBxIdx7rZWbblmocu41
ttsKThIu59lwSs3S7V5e9+vDwZxjxuMPY8H4Hrbi655+2W3AXxjzxq62s9cAnjqJ7L4oxy7P
arl92L1cpG8v39d7Yz/UHtRGmzEtMN22Ymy12mlQ3kQbp7mQvkXoQC3xcZ85/1r6dQ1nj/oc
5+4Q20PGu5DPjKXDw4POeDuYI9Xz5vt+CUe4/e7tuNmSojyOvPfIMEQzO/wsFqnYjvFaeYYJ
Je/l109kY+8Reqeu0UrrQDWZE6oCerpMozCt//yLicRiIaKdgy8Y70YLrxRxVDIG2haaCZom
fSd9nBBRHH28cp9sALkQoVz4TNp5C8/HPIdnv5zE2STy68mCbk8Ud0ki8fJK33yhe9l4R673
R7RCgoPLQaeTPWwet8vjG5z5V0/r1Y/N9rFvios3zbgzMfRC0V3JkRcV72lbNx476AFNfgYf
aCBeBPIXrWutl6vWkgdEc+rnd3WosqR9OCVQYpkyUMxQWpVRPLARVQGjYaFjr4Rzd+LR5r6d
iZEfdQYK1pr6sOLA4Ej68D9dD5GdeqtfR2VVM219HlwLQAGIvzgcHur7CHHkS+/uC1HVQDgp
o1GEmvNCDjFgITnoNdsyC6D9P4AbmRMJV+0LMXpzEulnNMNkYu45u0fOh+nxzMtj24F7JFq8
RcIgEnb5FVmOopcELO6xePi7Xny5HpVpW6p8jBuJ66tRoVAJVVZOYU+PAJgYd9yu53+zJ6sp
ZabpNLZ6cm+nQ7YAHgAuSUh8nwgSsLhn8DOm/Iosx+k/AURRZH4kyuhWwpwoYVlnoEMyELRt
+mWK8Amq7lkiYXlgdzuVMqgL7ZuAYR4mpXWj2Xk7IxANGxNRWKmfsRS6GwudEXOqNSN77hGO
aghnHlRMYnMzbTV5Y732pzG+q4/5ovHnve49BkbqBjUC6j4SSCEMLBffTEeTmIDkUL05hHlt
v3AbFNn4uxNZ6ui/YWBPfjdJORrb9e6hOxBAlIR1aHL0YdTbSUrgVcbduQ7jqpi2hlPtbAGL
GvBsfBRKJyQf6ATgSK71X0Fa6apLX/eb7fGH9oZ7eFkfHilHGJMkUodB5oQQwjHKDX3HbFJI
1qA2xCA54/al4eufLMZNFcnylLs2gRlCE5BRC1fW1rtLhQ7myj5y9jBG8bU6VSPxMhAvtVQK
0KVNpiZx2QSEv5cV0n6QZKexO45tnte/Yihoo4McNOrKlO+pSTdfw5SPRCdNwOo6wdySsGN8
i0JDBZ2u50KlXz99vLzq75wcWApahyacKbMIdMOCycgzlRhJF4PKF6UgKc90u5A+PnSi6UqC
kZatLT2A6J7WWRr3kkibVnT2xDqsUlNFU1D9mbmAs6vM8ZkMc1r6w8yKrYr43gXpubU0FBSs
v789PuITV7Q9HPdvL+ttP3e3jo2DOquiDembrrLPs5o3zCaB13u2ht9EhRMf8QqRgtaTRiUc
oJDJ2rU1lJyKdw2uv7rGGGJIGGim1L7hNW+FXWN9zRoIWeeWLjjLRdMgImpZQTMdbCabp8z5
WYPzLMIATszR2Xwl875JnwtjH1dei0b3VGPg8za7mM2UgTjAx9vxJm8hji6at+eqYNNKAQsI
GiyZBoYjONq7pbLongS/wYlUWYl43N8G4GjeOIPot2X3pOgeo/lmGGfz8Zd6YDetiMKO9TIA
4PtBX+XwfT1SAz3FsetD0cwJRW2anYgqCBql+ESWgiOsEQ2MxjeN+gzCvGsg/kW2ez18uIh3
qx9vr4Y1TZfbx8EJNQUuA3wxow2Le3C0Yq+kncEAw2ahiVGVQ3dKIAEmEqUB1tMKpqIEXZBE
mt+4Q/6jqlKbr5Fz5R60MfABNv3w9qxjO564So8C9LT2lCUsHlHnySCBaHK4SKj0zKTMB0zE
3B/gg+SJYf7r8LrZ6rSdHy5e3o7r/6zhP+vj6rfffvv3qavaFFy3PdGK3NhoLFfoU9yYfNOn
SmwDx+WgQjwFVKVcMHfdzRYknEuH1Hy2kfncIAEzzOag6jIu2KZX80IyyodB0EPjuX6TX7aJ
7hPDwpxpC+dYX7Y2CjP9bf1VoICyUnJ0cDzt8m6gpPbdbbrQ0VSrov8fW8dW4YAj6qzwdP9Q
lYK5q6sUY5EBRTiSrzfSx4g/hgv9MDrBw/K4vEBlYIWXaISWildyLkF+Bl645LN2NogGt1sd
jhHNdSBKgQq9qgh3iB6PYYY0/KqvYP7SMhJ9W0XzEOFXtGYDAFh9ETu2EKKc3WeIhCZe72mL
3QwIlTcFdRxq3Zl74xhR9U2jTCtCje6fiDT1gEaHt8N0V/FOKvXvBtE2bXHdafl6RGogzDvo
RIl8SuO0p7tQQ4cN6MI60U5hMLl4pTpAQccDJB6NCZpjWhYDDL+paFqx3AigRp+Xt2extivd
RAyGSTMQrcg5EEBtAOkdOtvQAtGBMJ3DmrgQmiNmaxRoMBnvHDO5zQQyge11/bpIRV5MM0ox
9IBZgcoG0k+7PA1NLdtykQJHEGhvayowoqlDhxV1InrxTL9qRJmDmIq7tJzW8hZYAhdcscA5
iiYTbpJO26r2gBamiVC02M2VlAmwMXUD/ULHJl7SiCSPJaX7Wcq89geNCi1T53aOK2Ne3GD0
7tWyPmzEAF93/6z3ryvmeId25o0V4VwqlVE3QohkgLajD86N2fyBzMvp12vr9gItw0GlBR2T
v/46bcc6jBag2DrRkiKqzf2aGw/7iouhc3HhbajjhmmRMOdEL4hcQRQxC9kCFnrBd0EKFd85
uPl4Uexbv3J9OKKigUq1j4nIlo9re9VmVcq8hrTyt9bLBae6b+YGh556zStInOHOnPnZ7ejM
BWcpKDa0Uuc9My7EJ9pTwInxCQyXD3fGMNiMOXkgdRZcpHyNkkSpDtLDY7D1vVYp0/vIIa89
NNxxwPW1fBZnGBCGxdJ+z3Caq92N5VKB1Obh7YW6e+/rgU/lIqgS18yYO2lj1s9wvwav8Bkr
Co0wA4yS8QXXCJpH0A+QGm7omYdX1dDb3oYu9BsLD6fuIvoYCh/uSuR9junk7EM0NArox3yz
j2e0Lt+OPRvGmLLhzS2IY3LQhoR18zDfyF2Tj6/z00wrDbSJbxilAfbzjAQ0m0X7gTp6q4Wj
a7NpnxPWKcdsuCRz7AeQfT4oSc6dr80EGNbZNuJG0L4XeF3J+CLKhD1FOpn7yDHDvPv8D8O7
wMbuAwEA

--k+w/mQv8wyuph6w0--
