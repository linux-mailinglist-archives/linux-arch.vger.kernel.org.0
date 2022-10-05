Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38B6E5F4CE5
	for <lists+linux-arch@lfdr.de>; Wed,  5 Oct 2022 02:06:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229462AbiJEAGD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 4 Oct 2022 20:06:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbiJEAGB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 4 Oct 2022 20:06:01 -0400
X-Greylist: delayed 122 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 04 Oct 2022 17:05:59 PDT
Received: from esa2.hc3370-68.iphmx.com (esa2.hc3370-68.iphmx.com [216.71.145.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 565D127175
        for <linux-arch@vger.kernel.org>; Tue,  4 Oct 2022 17:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1664928359;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Vrv9+uzAJEOfQe4FgTfjQ66jP00/Oeek1E8mQqIX3y4=;
  b=Ltqxmw4F0+tEYZnR9Y7lDpZl4Hqa8nPx5A2cGawOI1pd7OvHzqsEbW2q
   Qyu3/cSaTe3kQnKnGpsFyPVbuyo3u/leM37g6Q3z9FO36w7meShuqGtr7
   G9wa0gSyfd8mGPo5ZwFti2a4fEeyrc4hxoTyXolSdGQP86wIrNCdKDgaN
   g=;
X-IronPort-RemoteIP: 104.47.57.170
X-IronPort-MID: 81998690
X-IronPort-Reputation: None
X-IronPort-Listener: OutboundMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: =?us-ascii?q?A9a23=3AvT+4+K0o3P9ljCekevbDix16xdENGXBdZdh2t?=
 =?us-ascii?q?fhEiSJ0pX3ahD4G7p1b710+SeEeH3qzqcZfga8wTB6N928+UVk0nZaMT4870?=
 =?us-ascii?q?BkuUwd4g2VCIUpU7AWjAnmfOXzYq+fiylviztt77KRT+pkiVJ/qlMSpI6oU4?=
 =?us-ascii?q?B8EuURE1f4AdAZo+l56LXFqeviJkZjuHggQ9NZLOczZYE4TVZybPznOcCWLK?=
 =?us-ascii?q?OCJGdFN274vXKX1v2+UP0MGXtrgtUVo77/M7aIvqxh7eJVx8Rhv1TvB7oB8n?=
 =?us-ascii?q?FovQdjTT5eWVdTgpFqd9uK21LCyLkQlYpajdO0RqOs5z0Lt/4gtpstpaWjcU?=
 =?us-ascii?q?JBqfvnQN21xdYFuSpQVQ8Qh4yzBCWwkQ4/vw0Rz5+L1EI83YkyIVZX/JUDvv?=
 =?us-ascii?q?48jL88pxyFNJ/h8i2iYWWUEHDa+3z9Uust+8S80VUHzjAo3GtxVP9odDsQa/?=
 =?us-ascii?q?zReeLVl3lAIQxQ0sowwu5lzvYrxFACe1aIspx+kzMlTQsE1hgPs3dm1RFVJz?=
 =?us-ascii?q?/xZk8YJbdaaASHZ9wT8nq/DMko3EbQrnRu5T82Ene32Q9sSvCjhrBVWeRdfO?=
 =?us-ascii?q?3rvN/KpnGq9xJ4mN9Gzh+zyxqhc0hsWyOnZ8sgw1yIMsayFLQDwcibX4ww8v?=
 =?us-ascii?q?B75iLrcgQbwbX5NLuIXuuvgsWd/LAjBm6489YnaBEKsVNvcInuitD8SbGWny?=
 =?us-ascii?q?ss91GIdhPmp/33Rr3/Bezlgxc4WHIw2wofVyYtYniBwTj0qIAnCcTwopEMfm?=
 =?us-ascii?q?Y/diaXymyyQ9t7lY+Y8yX4r7TNHAA1XNL9WkfodjyG8EoOzB5XDYyG4Oay08?=
 =?us-ascii?q?JhhcnBKrWc0BEkgdJCwHVnW9i3MbBNn5Qrx9BEgyipeFJzyNX6nNHMS5es38?=
 =?us-ascii?q?OYcsRxQuNSfRJLlcJZ7ZnXfIMj4GbvXPxRPSgrGrRsG5ZDERwQF1bdo/dNS8?=
 =?us-ascii?q?bUmoRE5G7w0AFhmuSNH71XD9zXvz8Ccs2ZlPQnFZKGo0vG0BeVG3VztPZKf+?=
 =?us-ascii?q?SPwpqv8i4W58XNpx+3dtOXVaurYnWB8ZIGvQiIuPwiT9xKulRN4f4e0SJAOr?=
 =?us-ascii?q?32CFpmsH2rIW+fwC8bol1goDMFcG6AviHVlEHEKjyeQS7q46UB6iy/2qnQ+a?=
 =?us-ascii?q?ruyatvB9UfSR0CTCGD6cxGHohmmz4BLIHoB88QH3CK5hUIism1hTQtI2TMu/?=
 =?us-ascii?q?DVUcsS3f4n3olJq0qntCtlkuj54OMskHdKajHJH7fda6QneJQI5BOt8jUcMb?=
 =?us-ascii?q?4S6UhQdOGduZ8nBjYqVVWuS9UE1fM7UQ65GbRwx9Sm5RVKoUvQYdBf6EaNBm?=
 =?us-ascii?q?lpY5WBkwo60rr0q11yx8/j1BmxCxDtqrgtOB48HKZadXofYtwFOFV5PF2DJU?=
 =?us-ascii?q?+NGSxueYvGQxkgTwl/gAIJ3UoHca//+cl9RpZwLUnHSUVGR/NRtgj1T/WmUr?=
 =?us-ascii?q?F/MdWtsIWppWFpSf84qYKH4dM7cccZ7wMFQCQ/xPjfMHpBWlYU+byfVOJQTn?=
 =?us-ascii?q?zHmvG/GT18W819fd8qV0Wpp3ZMGxyPaPlX2vKqtGWmgD/XOdH5l7VBMZ/7qg?=
 =?us-ascii?q?VKCU6bRdMEN/LETqsgGeT3TaQ3ZmpZn+OH2XIGxCgkbPn/xWcgDge5/7DzzX?=
 =?us-ascii?q?6FzH6A7ZRtxMo0Qno1dEp1LhI9JGBvW4kK+KCM5X5HnLvmw/FpJTLWz4trGl?=
 =?us-ascii?q?7tlIjm1c6+YMUfSlIa0j6QZ+ox0JkAjqxwFEVObcVhsbErhfHkmvwecLdUoc?=
 =?us-ascii?q?i+/0TWOFEiSjs03UT0ggLrYzVCnZofv6KJJlz4nFoiWpEyk632I3NQdYgbIT?=
 =?us-ascii?q?C60H/gCkwnygEcTKbyNHkyqCv/dMPyXNYqRV17aZytA82tJF1+ed6DqpQhHC?=
 =?us-ascii?q?sdjvPIQS1WXLfo1L1joYRePaGvL+ro34vpU/6YDWUC2Uw+DtDVmMEyikfXY8?=
 =?us-ascii?q?U4r8lz9ID850LmMDVIt8RbNeH8zLkcqPI3HELLJs+eYDsanWPN6WWASOAFEr?=
 =?us-ascii?q?82f6GJ10v7RF1UzodHXKgxBiL4H468cdT3JbVGDnf221RVpgCp6w+uWCjR8r?=
 =?us-ascii?q?p3rEcATMUNp8EdoWcRStcK2KFpS2XQmZ7jl1Gy6OXIL4xmwPosLpR386EBMw?=
 =?us-ascii?q?AFenjEkmBIBZGVcoLrxnntigz9/6TXUqHYp3J+Zvk/hlp3JnFUoKw2B9wmBV?=
 =?us-ascii?q?gJBDC5kB84bTHvCXMGgWofvvA2vAo3pckCIiWUsbhOXsGiAy91lSIAQ9KFUR?=
 =?us-ascii?q?xqX//xeovTAcjozlCYF5jgsk07GCH/L7fJKQpj+kR1Lk7GEuVgJwu/KvMFrp?=
 =?us-ascii?q?peEvZpv++RRIixrepLMYd5/jqp2fZIHn+36FaTJz5NEQ1eRgctzTSLLssuer?=
 =?us-ascii?q?2cJzq2kdWohn9A1SVETtSxzFE7LdXB3nPsWtXB6Qr1YRZrosYlROvyBWCO5I?=
 =?us-ascii?q?0HKmaup8/ieZyaZaBaqdvd1jNshtm4ivBMakMLzrdfI9j6YMAtvg0YeF72S4?=
 =?us-ascii?q?jMj5aFtzkN1w6Q+TOzpEShhhrRECKFQ6GhR7Hk7cxHdt0I2j7NMNwnNowI0g?=
 =?us-ascii?q?bWlqoLpSG2vEfyns9b5gX9YMowhYHxmU91Bt2CagHZ9FNCEBRPSvhlfbjOzt?=
 =?us-ascii?q?/Lj5lBgxHzCUSKZ066Lnr5TwddPvdIr31UY5NuC+LbVKMw3IKfo9ixYfkgO+?=
 =?us-ascii?q?KR8UfvIOcQo93XnWorI8boVcj5JsLRkkPVCTocKF6nUrAvWLUs/4SnjfuD9J?=
 =?us-ascii?q?w1dx1G06UqQYLczvfac+Fpy+reakhQVeZ5CBnuqd26dUG8iEDMHPWzEyDnLD?=
 =?us-ascii?q?DPV6Yr9hbiRkwVCjbdqLZhSl5uOAz/4mGcshntnSQ+UDqfWlKlnSKP/usQFj?=
 =?us-ascii?q?qxAw4PxNNHs956hSZexayamjbSKBsa3S6alKnwm+o6KWiFuqvdtS4HTD68SS?=
 =?us-ascii?q?UpG4m2HiUAr0TI5n7QyGtc2y8Km6a9iCJXnhVPVxGqJIcX1/0nVVcDMZ3qW+?=
 =?us-ascii?q?NE7nQ6hJk3AjVaSXzp0PN64/D0uJkDQkZFCJGqVV6+pfD8pd92WW8vpngfJi?=
 =?us-ascii?q?RkAQxbGbb9fL94sF9nQailWi0kAW9DsNHcoBy43txDfTV2MBwH0fTj/3n/yK?=
 =?us-ascii?q?d2P0iDzugyCgK4c5ttP/UDS2NUCQHbRW21kLgVAbVdojn1H7VZl9MWU7oldd?=
 =?us-ascii?q?NvKkzevj6cq9FXlXG+AFpr38CZkpA09FBxrjkcNFY3UKb+JkoIgDOy7zHRqT?=
 =?us-ascii?q?NKKfvtKXqGs6n/fOa0KwLw/sRu/aNYv1UZ6SSD5+t0iuPOIAr1/IRJru/v56?=
 =?us-ascii?q?+amHTSV4Goh82aZlAgR1Bt8MfsMNi/YoUWTNAwQPGH0mbAJ0UCYuNYQmlkp/?=
 =?us-ascii?q?vgRiinKtKyzZAK9t1ES4Ws0egmqzPSfGa1db9fjb6V8ogdWPAfmXvEdXG+QG?=
 =?us-ascii?q?WoQwRuS4p/VMLiQwL5UMm7e5f3Df78jkPwmjAPvbV5Ub8JbMTtf6nmQP6DUT?=
 =?us-ascii?q?P1/pbtEINkYKYx4lnwURtHq9mk28mLE4Php5MO0VLvjLUllcxGBJjLZ4rhTS?=
 =?us-ascii?q?lF7ENHxgwBOLpyghrqxAeFcjtZ+G28WsyDiBFIbujR6Q4nawoFAJfjZicBzu?=
 =?us-ascii?q?TS07/BX6zhQLkIDBmRYTX3Zmyqy5xOOZb8szd1RqM104OCScLCQwA78SJE7x?=
 =?us-ascii?q?10CGwuxU5G3F0GFRqR7NbPFeu+fqZM8CX4EI7vz3UXBr/MhiTeNA1vwzHeoY?=
 =?us-ascii?q?XpP5x5H5bjEgKCuYycSTIWkLU0dZAOff8B68m9UkjKhfeTo6wc3SKlNX9IXZ?=
 =?us-ascii?q?or/TcB2e5lVJpPAvGMg1ZfvBUNhRCXrSB4Rfn8tGoS5e2FK/g9loWu0Lb3U7?=
 =?us-ascii?q?QREXfo1bp7Wj6gXyC+z5ykb+voM7TC9oY/ER287+DYl27giJcOyMLj7U27cA?=
 =?us-ascii?q?geyrcne6lWoj5olPSx6O5e/JCw852XweaO1XKrKqM+ike+PpUZMt5dgwa/I8?=
 =?us-ascii?q?RlEt4fYkljmSxrFcFjHYUyzpP3voPmyANq2ECwC4VNQ6gzwkKH6u7g/fp1D1?=
 =?us-ascii?q?EFxayF6wBAQ2h4HO8cwoHccbR7GHYkSsad6z8wW1IVNS1oNHpWZWmuddLUVp?=
 =?us-ascii?q?6yOkxuWt0co464YiqRO5HgA615Bi3InI7Ovk7y2wESrr56LJ41WKB19Vvtm5?=
 =?us-ascii?q?FZKptK/uk0Omf1vyn4SSPtFohpkY6IlQKjG2fZ5IO0XfkPMr0NtiZUpuJDRg?=
 =?us-ascii?q?Xk6IY4ZASQS3PqPmvqLi+sR4jlj/5XefkwC08Qw3DTiSOfCmEnDbytLTZv8B?=
 =?us-ascii?q?i5Abzx1pR8/UK3ewKq0HP9jg121gz81bIVLYVyKzA+JnENkAz7KU7qrxeRgr?=
 =?us-ascii?q?+acLwL4tXpwNL078Hm0CRAiRBer2xuHNktVlC8b4q+ORz58CZTKHguvr1QUZ?=
 =?us-ascii?q?TulGMFwktyOoBLvj/PLqErELfBnrceUVZaPsKXuagA1iUuhKTTcgJGu+h3ey?=
 =?us-ascii?q?oqtuWjQfM/a7dJYchAaVMrVAL1cINE5cPGddd4CdOCO4dp9DjSwMN1JUc6GQ?=
 =?us-ascii?q?3vj5l5jj3hQGA0QbE6z0MesiXgMXWfbO+/MB15qDPLW2TkjI9TUgAvMwyHvD?=
 =?us-ascii?q?ia4eelYcqRQdDdT81MC8zwGtdMqnSyhh4UwIHZ1gKecTrW7jshp1PTo9cahK?=
 =?us-ascii?q?I11rb0A5YAfWYLSyjdflMJlAbIiIQW4dRcgpXU5bJh87emQ3QugRXOndhPXU?=
 =?us-ascii?q?qEtKwwryz7QyyT08ThiE64NiFry3ZMFonR3Chqa/YWXLKpvEA6GuM1D7ia38?=
 =?us-ascii?q?vfZvEeWZg1BHz9QVD0Lqt96asHHGptRllP4D7k81FM6u/PYoCIN/U9rWfFH4?=
 =?us-ascii?q?HMyAs4WRWmtFl4AowKfQLngWsFYYNEj7VzCw51ogMf+8TpfUWBdTpDt/vlzZ?=
 =?us-ascii?q?zRKCAR0Mo/G/QoA/JWiFwa6cGl1AKrSS9pykNgCVmwRlyI07iwag89L0ms2/?=
 =?us-ascii?q?uqMeq5/4uu9DDQ+EDtk7HX1CWDDohwnM/W5mPRD5QWsyqQemg9fNrC9FrOv/?=
 =?us-ascii?q?nQ5INWUNWZE8IQ2KYe9yrUv2TJtEqcPE1zv2NEe0PFX+w6GMCIT09L5gN62I?=
 =?us-ascii?q?d/wcNQl/FWvaXHImlOwhLBFMyF2iLShuq67fQgFR8LZKZp15cpDefI833sIp?=
 =?us-ascii?q?ErnlFfFg/mQAGP4G5swccLdqULouZXMHgaaqejdlnskA41SglogUiScfj9d2?=
 =?us-ascii?q?Wt7qyGotSIzfv5eL7rrT4etm5u+Jqgiuhc6HSFBt5PBiroVWDUi4iB/gN8Az?=
 =?us-ascii?q?dL4t2vMCNJaJAi0rkGulkoP2JNUTpNIJYfgDTG0zdHb0kwqLde+NmBb8/mDl?=
 =?us-ascii?q?h4ui8JWGWwnkKTxsYNz4aZnT2myd57uo7NyQ70Bw5rJ0bvNNdsnQFqFyydWn?=
 =?us-ascii?q?1bwj9y9AUHS9vu9sKDe5l4riohl6pmSHdA1SXmfF11vKsQK5UUde6skZLupG?=
 =?us-ascii?q?eVdb9b2Ey2lAGTvikTRIsgI9f5nGGdJoF2MugScGq73Wqw+d6qi7sFKQ/y3n?=
 =?us-ascii?q?CnC15s1e9ck2Tg=3D?=
X-IronPort-AV: E=Sophos;i="5.95,159,1661832000"; 
   d="scan'208";a="81998690"
Received: from mail-dm6nam11lp2170.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.170])
  by ob1.hc3370-68.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Oct 2022 20:02:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fiXpsiVd3i2DHbRj9YrozP+5SF4dbLNQUBJEHXLo1WUskIw7BiN/fW19ThuaSL+2o0TpgFeQ3Z5Gf33QEwws/PxwVnysnfqMsnsPo92va7ry6whUkTlpUDWJRo3Djw6SoQiay0Zt+G8hirzAcYFCSNU35TCKeu72tFUiA1VrO2RagfqDCj+aQY4IBuu42lqU7syfbf9opnu6JPZTP+CaPCDlPcoO1SULn9eIOp0X9YVntki9L5pts1hE1Z8x8wFwlGWFl8Q+fEVuEfE7bNbw99qpktvgcJso6KQ2+URmKGcyn3MzJOd8lBfkryjEPF4O4NM9E+iUMEn6k2ZLU+XSzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vrv9+uzAJEOfQe4FgTfjQ66jP00/Oeek1E8mQqIX3y4=;
 b=CGAPsK/xC7pizo1v/+cKYMqfvKG1L+khKa7C1DLye4s4jWarvdgQQ0vltDHYUlKl1s5EgccilpuBGyLKTamGUXEhEevo6AOCd/2qHCthnSXGTyzzrpXCT2Jj9uh3uR+zBd70PJuSivFzhYbIhnjRA7xN2mQ4onS1QAzfdAe8ZmRMbWWmfAe0FdZOQls1hJIsrq8ZffrWQWDu6HZ1IAOdunHquiHA+h0Fxnzv0BR1JCzNWe6fatgLBbOX7QCfevirfMyCJC+AP6yxxKGFDQgoor3qmXNlGXAgBZzKc+Fj2VfJPjGZkia5gNShWUOeQO+eCI2FSiSUFoc5XXH8ryg4Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vrv9+uzAJEOfQe4FgTfjQ66jP00/Oeek1E8mQqIX3y4=;
 b=aEw5Kh6suBywgjlAZaryw+pJviKNluQj6JsnjRnMItBz0CoEof0pkD18v/WrwdnYn4SWsKC0GvikEgeetcT+GoDHqYiC3Ef8xrQE7ErA0lncNH2E9NwLkSeBbxOsDrNxt+BubfNwOO62x1AG2eTbt7NoQODjxernSOxnR0k8tY0=
Received: from BYAPR03MB3623.namprd03.prod.outlook.com (2603:10b6:a02:aa::12)
 by SJ0PR03MB5583.namprd03.prod.outlook.com (2603:10b6:a03:28e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.28; Wed, 5 Oct
 2022 00:02:46 +0000
Received: from BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::988c:c9e4:ce0d:b37c]) by BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::988c:c9e4:ce0d:b37c%4]) with mapi id 15.20.5676.023; Wed, 5 Oct 2022
 00:02:46 +0000
From:   Andrew Cooper <Andrew.Cooper3@citrix.com>
To:     Rick Edgecombe <rick.p.edgecombe@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H . J . Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V . Shankar" <ravi.v.shankar@intel.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        "joao.moreira@intel.com" <joao.moreira@intel.com>,
        John Allen <john.allen@amd.com>,
        "kcc@google.com" <kcc@google.com>,
        "eranian@google.com" <eranian@google.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "dethoma@microsoft.com" <dethoma@microsoft.com>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>
CC:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: Re: [PATCH v2 01/39] Documentation/x86: Add CET description
Thread-Topic: [PATCH v2 01/39] Documentation/x86: Add CET description
Thread-Index: AQHY2EQDv5/5lSBhA0Gvog7WqTu2Ga3+6w+A
Date:   Wed, 5 Oct 2022 00:02:46 +0000
Message-ID: <fd17dd3b-5cf6-4676-b17a-5004545df3a4@citrix.com>
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
 <20220929222936.14584-2-rick.p.edgecombe@intel.com>
In-Reply-To: <20220929222936.14584-2-rick.p.edgecombe@intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR03MB3623:EE_|SJ0PR03MB5583:EE_
x-ms-office365-filtering-correlation-id: 91595885-7ae5-4dfa-bd76-08daa664eede
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nTYknR6alJ47lai20f+Y9ITazN8zdUL10pNjxqqYHSegxwH+f9/s+hvYN1AJbrlyd1cf8gfLU77hHaBfu4m0JtMFZx0CZz3iSJB2yvKHfIuIP5EMnpOSREuu5fK75FeRLqTOcf4eoFSOUsAH4kcmiJ8wNsNwNsANvLYpRckXCK7vx+EWdLTyZxYMXbXiNziIlEeCPYgVTeURcr2gNs1EKReuGLGaUzazjmE5rqc+PSiMcppvtDM7aJNg7ASQyhCAILwKUM1IZtQQLQfVYR1MQaNbHds0LhNhNvPW2LmM2bjTX+1UVrtVc+Avyzrf2FCnkH71vjvVygR+xfo4jfOd3CEgnlHgCriIpEXdeFJwWsKpHltDSQXg/uOzcZdRfD+cH4Ma8M1vfznGkh2Hy4nUJpzQ0CXIA5/NH6QbJH9Sfjdh9ko7frhPLdAX8CKs06aub8+boIG/6mO2Yz4D9j7vDdlCfSw74SYLlCrhfhtqJeC9QpSMsz9vNacAA27F/jHu0S957fq6l6PtTKK1SOqicQa5zgcJflG+/+mg7vwDMszLhRzd4rPpr3l875vx2jh2dA1tpZ00aNc2xxLQvsW5ygT2mU5J7O6nxUdOqyqUj6fLRFM056UarahmKWDa6b2BwKkizQtfZ1Xk6XlTxMbXtFnYkcAyrKoejCDESEp6nPSaJmgbgW5wzjTCNfKV5Btzpvcv85MuGNfTTly9avm+D6PevQkE4+AWCfajckN+FlVaOODshe1X4hICkOE4cb7q5qLzOKwqqjSyVf0n6OcISVwnftvehPo/WCvcpKEMXvOPcGS49/iw3IhmmqPqC33wmerNxaSdcqtFAngAgoHtSgIbhASr4HrechTE80Ckfk0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3623.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(396003)(366004)(136003)(346002)(451199015)(83380400001)(2906002)(31686004)(66556008)(86362001)(66476007)(76116006)(66946007)(7416002)(66446008)(64756008)(4326008)(5660300002)(7406005)(53546011)(6506007)(31696002)(41300700001)(8936002)(36756003)(38100700002)(186003)(921005)(82960400001)(122000001)(38070700005)(2616005)(478600001)(6512007)(26005)(6486002)(8676002)(91956017)(316002)(110136005)(71200400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZFlrNERpcVNzT2hnZXUvdk1wSGZvYmhsUE5qeko5d2svUitOMHlWVlBTclYw?=
 =?utf-8?B?TmRxWWQvdUlOelFldEhtZkFCNXdOdTdDRjR1RklCREMvVDMrMjJtMlpyM1Nu?=
 =?utf-8?B?U2EyRENzaWsvZVlDOFFTYWRnSzZ1Z283ck9pYTZqTXgyOHNYamh1eHFSQU8r?=
 =?utf-8?B?dmdUaE1nME1hUmpWUm0rWW9waWlZRTRlT0VJUEpmTVZXcEhVQ2JtaG03RWFw?=
 =?utf-8?B?K1FtNS95Ynhsbm16ZWtieEVtaFZMSG5vbHF4MHlON2VWVlMxSW1wY2xGTTFs?=
 =?utf-8?B?WGVZTHdwTXFqbnpaMDJVR2Z2SEdRVG5sRnBFLytnZ0tZYSs2eXZ4K0w3SnZM?=
 =?utf-8?B?Z21mSGh5YVRqMk9lQlVkd3YyY2pGM1J2UCs0ZjFYUFd4SHZtWUV5QjZqUnFq?=
 =?utf-8?B?TC9MY3lwQnZESmcvdFc3b29DWmFzL0wzUkxicGc5MFlOdXdhVTZ4bGhRQS9x?=
 =?utf-8?B?dUNUc0tKOVlOaUZ5ZnhML1NiamlTZEJuTU5zQUYya3lDUzJvWHlWOGpoYzJT?=
 =?utf-8?B?SzlPVHJvRFh6My9QUkw4bm1QNFJIcEtPOHhVME1PVitsWDB4UGhrdnhGVjlT?=
 =?utf-8?B?N0x2b0xhUFhmY1VmSkppMEs5TFhYaG04UXBFd3EyK2xLRTR4TXZrVnBvQ0p3?=
 =?utf-8?B?U21uTUpnVjhZU0lTcGkwdjJnbE1pN2liKzlZekVHSnpDZ1RYbGh4VWdWaFZp?=
 =?utf-8?B?K3BHcElmUThGVGgzNmJLc1pYMzVIM3ExRk5DUEw5NldWWkY5TVB1a1NDOCs0?=
 =?utf-8?B?UmxWYTlWWnFFS1kzOTQzTzNmRTBheTdJZ2ZhRE9ZcUcyNlRyNkwxUmtoSGNN?=
 =?utf-8?B?di9YOWxpWUlGZGw3WEFpYS9JRFg2NnpFZ1VOMmIrODErTlR3aUw3YmFUUjVK?=
 =?utf-8?B?K2tSekJlbENyNGRYQzA4dTVCMllWNEd5ZDdsRGhURmdHQzFWZDB2ekVPUnhD?=
 =?utf-8?B?ZTlwMkYvUTlHejVuUkRMd01tZGFqaHlBZEw5eFgxS2g0RUFMcW1IRmhuWDg1?=
 =?utf-8?B?Uk5ZVUQyRGluYmtRL01MOTdheUVZRVpSYVhCbHg1YjFLeFQwRUVxdzhZSlh2?=
 =?utf-8?B?UTZoUDU5bTFSUXQyZzg3dkJPVkExOC9BSzE2OGlMeFlpczNWUXZFdUU2WWxB?=
 =?utf-8?B?b2JRclBWNU93OC9EVGZyRGZhandORXp5anlPckhpaURkSFVrNzNzbWt3cXlq?=
 =?utf-8?B?NnE4bXIyRmc2K1hTNUEwRy9veVM2bWlhZkpiT0FpcHdONUZZNkhibE5TaVNq?=
 =?utf-8?B?MUpmQjdZaG41RURYOEx4NXB6aEo2bWozbXUxODhMb0pKTHNhNWxQYjlYWVls?=
 =?utf-8?B?OHFTbjlFc0h1b01zSVBwdlBpc2tmTFAxbGNwWitsVFpSdjZwUmFlWmxsRVpY?=
 =?utf-8?B?dWZSb05zYnpBK1pUVHhaNFFEVjRhcG0xcjc4VHBpcThFNFlZcGhQTFNTWXYy?=
 =?utf-8?B?YnAvcWVHT0FzZFhJQ1JsRlFqb0JWTjlvUDNlRUk5Z3FXWmtkSU9nYTJRZ0VW?=
 =?utf-8?B?UWRnMmJsRTMyancwWjVmZFU1UGVOUTk5bE5WRS9rU0UrY0VBZndsSkhhcEJv?=
 =?utf-8?B?Vk9KTERsSS9RNVVYZ3MzQkd2RnczWmVhbjJrdWNBYURaVVhzM01JV0NPMEpq?=
 =?utf-8?B?eVR6TWRTVllXYVNsVmhGaDAweU01MUV6K1BWWHpwSThhSGVLc2ozTUxDbFMr?=
 =?utf-8?B?QVI1dUpFTVAyOW1MNzhLeFpOdnlod3h5MytqWXlSYjVQZlk1S1lQSW1KcUZt?=
 =?utf-8?B?R2FlVDJzcWo0R3UvcUVvYnNpZGRidXVYcWVpVkNwRFU4WXdmVEp1Wkc5WDFn?=
 =?utf-8?B?aEZQT0ZWa28wc1FnaTJKVDE5bGcraDltVGlXazRsUHpGa0J2L1hvdlppN2Fp?=
 =?utf-8?B?dWROeWN0ZGUyNmEySUJlRzgzOE9ZckFiaEZuTXZJK3FqMnh4VDFCYmZ2ODdq?=
 =?utf-8?B?b1h2SVRXOGxSbmdCVmVQVktMOGVpL2dsZ3lUNUxjT3JBL2VJbC9oOHlDQ3Vy?=
 =?utf-8?B?MElqbHVrajBhQ1NPMno1RkswbFl6ZE5BaXIxb25TeTNkNUV0d05oUlNGT3NE?=
 =?utf-8?B?elBZdnI4TzdpY3lFVmpVN2ovbERoR0tBeDBxUnZRendhNnY1aXA1OGNuQ1ha?=
 =?utf-8?Q?bnDgSuBmsl1E00JKz+M8ub1WO?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <32CA19F1C1CC7A45856264A47F65A663@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?YzN6MjZaZk5JZzZyb1V3QWZIUHowR2V6VGkrWTlpUFJkWVppeU1kd2xNakc3?=
 =?utf-8?B?ano1cFBNeUZRZTI2UEJ3ZlhPcDRFZEJGT1VlNVZlSFhjMUFBSm1sNDQ1SzNr?=
 =?utf-8?B?SzRuY0pDeTRXZTZ6SzllODN0YVpxSWEyMVpBSnVIVjU4ZWtTaUFHeEEySDc2?=
 =?utf-8?B?NG1NQXdhQVJKejNCeFRCb1FTeWM0M2s0NVBYd3ZtMndXRHFlOHlsRXVtTGNM?=
 =?utf-8?B?UTJiVHk4NHR6SDlzbWhoMmJjZjl3S2N4Z09mKzkzRjYyUFphVjdhOE5OVW1X?=
 =?utf-8?B?cndoQkdUTWFHZ0tVK0VZUGlQcVUzZWpoMElVMEdKU2Y5d1p6bVNQR3hNRmda?=
 =?utf-8?B?RXY0Ylh0UXpSTHRXVnpIanNNUWt4cTBEa3pSeHJUcjJGMmxEL1Z5ajYvY1lE?=
 =?utf-8?B?VXJpenhYR0c2N3lLdGZvOFBuOWMrbTNpdFV1WEFEcXVtRVJqVmJPcFZaeVZl?=
 =?utf-8?B?eXRyZDRVb3BwbEg0OCtFUWNQY2lIdGxZcURkTWRHdkZ5U0V5a1lZQVJiV05n?=
 =?utf-8?B?aklhRDdHRFF1emNNcnlEeU9LYkZIbTdJcDduTVRrTDNHNldLV09mdVg2TzN2?=
 =?utf-8?B?dmp3VEk3K1lGQ0NTbWgybGZ2SHNHZ09XNmZoSXg2Y0V4NXpGNTZ2YS9zV2sz?=
 =?utf-8?B?OUUvSzcybFdyeWlpUzc5VW9qL253RXQxcmtrSW81eGFYZFhZYlFIRmpVWWFj?=
 =?utf-8?B?bXNhOHRjVXMwUVA4ZEtpMjl2a1l3ejltRVBXUW54bHF3Z2l1bXJaTVdXaVRj?=
 =?utf-8?B?anJZYXVyNWdRU2MyT0huR2duZXlIUTlXOCs5R3JDV0lwTDQvbTNDcUJ6NUZa?=
 =?utf-8?B?N2JPM1FseE42Z21WcTNkMUtGUW1DQ1g5S1VKRTJuVStZT0lGbmFDMi9vbFVQ?=
 =?utf-8?B?OVZITFZVcXlqNFoydnU2a3VYbytUQ0F4d1l5M2Rudyt3R3JzSkNSTEx1NUZW?=
 =?utf-8?B?ajVhN2tRTzF6UnZ3ZDF4Sjd2R011SFdJS2xWOHdKdFYzSE5BU2k0THh2ZERq?=
 =?utf-8?B?MEV0MVVhT0RZYUlORUVZR3VrL1ZySVc1WnkvdFNlZndMY2NQNXF6WmpsSEgz?=
 =?utf-8?B?Z3RKQjdoVi92V003eUNCcHhLRjdxNkt4TkZvSEV4Ni93UHRUZExiMmlvNzVl?=
 =?utf-8?B?WndwSmJRVmtCU2xRUXN3OStGbzBxTWVyYm9sYnNzYVMveW5TcUE2TU5ScWJn?=
 =?utf-8?B?NW01K1UrNXJLQTZBWU5SWFZaYUdkN2ZxaEtoN3gvcjVvZUVaaSsrWHcwdGdp?=
 =?utf-8?B?dEZDZHh5WHIrWUhNckwyTXJTS3VUWVgvRERISHdydDZXaXhLTUIvbFl4dENj?=
 =?utf-8?B?YjJKWUhHOEJRa1dpa1U5QVBSbDIrNW42TXhVZHRTZWF5N3JLSlBiQVF3YkIx?=
 =?utf-8?B?R1lZbTJFeGVFK0dLYWYyWVRDRXFWZEZwSjh3S09BMUFzZGpjN0pTN09IM1kr?=
 =?utf-8?B?Tm0rd0RKbnEzN1Q4aEUrUzlOcGxNeWxId2tNVlptdDhYeVYwMTVEaVd0QWlx?=
 =?utf-8?B?QzU4aGhvUnNHRlNSbXBteTBsaW42VE5qak5ZaEFqZ3ZtdHh5WlpFbFBjaFl1?=
 =?utf-8?B?dC9yZnovODB1M2ovUXVUSnVlNTZrN0RUUkNJeHlPVmRFc24vZ053d3BwT2ZK?=
 =?utf-8?B?cGFtTWptRU80U0hNc2xiOWVMclNRb05SMzVDa0p3TWRISUZDS0sxMDBDM2Jp?=
 =?utf-8?B?OHhJcFJBSm9ucHd4N21DRHdhQU01U05FTEZaeXlocSt1eldwVHhsR3NWNUpy?=
 =?utf-8?B?d1YzZ0EvY3NHcmN5VlYzQUhPL1VKYkJ0NkZOTE1LbnZkYWxMQndJZC9kcjdD?=
 =?utf-8?B?NTZXSGxLbDJMSUpzU0xxS3Fpd1BCM3VoY2NtYm1oRkFxOHYyWGVES2FJNXJ6?=
 =?utf-8?B?NnR6UzlKbUZ2Z2MzTUloc1dqWEZOSVZUVk01M3Y2R2k4VS90MnBQQmJpc0o0?=
 =?utf-8?B?VDYrSC82RjVBRWtDcVI5ejVURjJyUXJaU0h3a0pSejdGQ1hZQjl4UHYzdTNP?=
 =?utf-8?B?b3NVNEk3TU5LOC9rZEp3WUowZHdYd1ArMm1pektydHJYaHZCaGg2bHYyK2w3?=
 =?utf-8?B?UENpSFViOVp0YkkzbkZGeG51aTJKanZXWTNOK3FERUl1RWdCRGgwM0ZBTFU2?=
 =?utf-8?B?Q2liQ2pkaWYwbDA3Y2IxRUlrc05rUi81V2ZNemVXL3FGUW5HdERPeHVIMXhi?=
 =?utf-8?B?ajZjVFpqMnBucnIzc1VKS3FEU0pWUDh0dnFZT1BRWFpvNU85VEMwbzE5aDlo?=
 =?utf-8?B?c3RGNHpYcUVzdEZuUFNoNUJXaHBQUmFYMG0xUURpR05YckZNRUtMenF1RFo3?=
 =?utf-8?B?MmVFM0o4c3JqdzlJWjRkQWtYLzdZd1lNVzBlTHMveG5XVWZsQVh6R0VYNW56?=
 =?utf-8?Q?pu6KEMC4fsQq3TYiKDlzGlVxLl7K3IRwr6oocTa06lTqe?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-1: hoiWcy7PbF6P7M8hUuOVRIRenxQCRBesOhsW7CiDrhfRjIIReInDAS3PBN0PVyX/byUMKmpYt9sC+FksR3ARDc9+4/1Bp6DDwLtSIaLk3Vd4UzPcPKDZmIONhCQidijV8bA/8LTIK43xZlFMe9XUr+ut4Qi/N40a/OM=
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3623.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91595885-7ae5-4dfa-bd76-08daa664eede
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2022 00:02:46.0705
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l3GizY4pthAWEZdwJnkGUaD62thxwTyFCq65tvZQsi+fnGiqezP7Y40fGy5ZCJydcf4wHqzraeTeVbsZiOiA3LgMzdss57qMQzV0JCtfp1A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB5583
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gMjkvMDkvMjAyMiAyMzoyOCwgUmljayBFZGdlY29tYmUgd3JvdGU6DQo+IGRpZmYgLS1naXQg
YS9Eb2N1bWVudGF0aW9uL3g4Ni9jZXQucnN0IGIvRG9jdW1lbnRhdGlvbi94ODYvY2V0LnJzdA0K
PiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPiBpbmRleCAwMDAwMDAwMDAwMDAuLjRhMGRmYjY4MzBm
OQ0KPiAtLS0gL2Rldi9udWxsDQo+ICsrKyBiL0RvY3VtZW50YXRpb24veDg2L2NldC5yc3QNCj4g
QEAgLTAsMCArMSwxNDAgQEANCj4gKy4uIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4w
DQo+ICsNCj4gKz09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09DQo+ICtD
b250cm9sLWZsb3cgRW5mb3JjZW1lbnQgVGVjaG5vbG9neSAoQ0VUKQ0KPiArPT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0NCj4gKw0KPiArT3ZlcnZpZXcNCj4gKz09PT09
PT09DQo+ICsNCj4gK0NvbnRyb2wtZmxvdyBFbmZvcmNlbWVudCBUZWNobm9sb2d5IChDRVQpIGlz
IHRlcm0gcmVmZXJyaW5nIHRvIHNldmVyYWwNCj4gK3JlbGF0ZWQgeDg2IHByb2Nlc3NvciBmZWF0
dXJlcyB0aGF0IHByb3ZpZGVzIHByb3RlY3Rpb24gYWdhaW5zdCBjb250cm9sDQo+ICtmbG93IGhp
amFja2luZyBhdHRhY2tzLiBUaGUgSFcgZmVhdHVyZSBpdHNlbGYgY2FuIGJlIHNldCB1cCB0byBw
cm90ZWN0DQo+ICtib3RoIGFwcGxpY2F0aW9ucyBhbmQgdGhlIGtlcm5lbC4gT25seSB1c2VyLW1v
ZGUgcHJvdGVjdGlvbiBpcyBpbXBsZW1lbnRlZA0KPiAraW4gdGhlIDY0LWJpdCBrZXJuZWwuDQo+
ICsNCj4gK0NFVCBpbnRyb2R1Y2VzIFNoYWRvdyBTdGFjayBhbmQgSW5kaXJlY3QgQnJhbmNoIFRy
YWNraW5nLiBTaGFkb3cgc3RhY2sgaXMNCj4gK2Egc2Vjb25kYXJ5IHN0YWNrIGFsbG9jYXRlZCBm
cm9tIG1lbW9yeSBhbmQgY2Fubm90IGJlIGRpcmVjdGx5IG1vZGlmaWVkIGJ5DQo+ICthcHBsaWNh
dGlvbnMuIFdoZW4gZXhlY3V0aW5nIGEgQ0FMTCBpbnN0cnVjdGlvbiwgdGhlIHByb2Nlc3NvciBw
dXNoZXMgdGhlDQo+ICtyZXR1cm4gYWRkcmVzcyB0byBib3RoIHRoZSBub3JtYWwgc3RhY2sgYW5k
IHRoZSBzaGFkb3cgc3RhY2suIFVwb24NCj4gK2Z1bmN0aW9uIHJldHVybiwgdGhlIHByb2Nlc3Nv
ciBwb3BzIHRoZSBzaGFkb3cgc3RhY2sgY29weSBhbmQgY29tcGFyZXMgaXQNCj4gK3RvIHRoZSBu
b3JtYWwgc3RhY2sgY29weS4gSWYgdGhlIHR3byBkaWZmZXIsIHRoZSBwcm9jZXNzb3IgcmFpc2Vz
IGENCj4gK2NvbnRyb2wtcHJvdGVjdGlvbiBmYXVsdC4gSW5kaXJlY3QgYnJhbmNoIHRyYWNraW5n
IHZlcmlmaWVzIGluZGlyZWN0DQo+ICtDQUxML0pNUCB0YXJnZXRzIGFyZSBpbnRlbmRlZCBhcyBt
YXJrZWQgYnkgdGhlIGNvbXBpbGVyIHdpdGggJ0VOREJSJw0KPiArb3Bjb2Rlcy4gTm90IGFsbCBD
UFUncyBoYXZlIGJvdGggU2hhZG93IFN0YWNrIGFuZCBJbmRpcmVjdCBCcmFuY2ggVHJhY2tpbmcN
Cj4gK2FuZCBvbmx5IFNoYWRvdyBTdGFjayBpcyBjdXJyZW50bHkgc3VwcG9ydGVkIGluIHRoZSBr
ZXJuZWwuDQoNClRoaXMgcGFyYWdyYXBoIGlzIHN0YWxlLCBpc24ndCBpdD8NCg0KQUlVSSwgYnkg
dGhlIGVuZCBvZiB0aGlzIHNlcmllcywgd2hhdCBpcyBzdXBwb3J0ZWQgaXMgaW4ta2VybmVsDQpz
ZWxmLXByb3RlY3Rpb24gdXNpbmcgQ0VULUlCVCwgYW5kIHVzZXJzcGFjZSBzaGFkb3cgc3RhY2tz
Lg0KDQpJdCBpcyBwcm9iYWJseSB3b3J0aCBrZWVwaW5nIHRoZSBpbXBsZW1lbnRhdGlvbi1hZ25v
c3RpYyBiaXRzIHNlcGFyYXRlDQpmcm9tIHRoZSAid2hhdCBpcyBjdXJyZW50bHkgc3VwcG9ydGVk
IiBtYXRyaXguwqAgSSdtIG5vdCBjZXJ0YWluIGlmIGl0cw0Kd29ydGggc3BsaXR0aW5nIGludG8g
Y2V0LnJzdCwgY2V0LWtlcm5lbC5yc3QgYW5kIGNldC11c2VyLnJzdCBhdCB0aGlzDQpwb2ludCwg
YnV0IGl0J3Mgc29tZXRoaW5nIHRvIGNvbnNpZGVyLg0KDQo+ICtUaGUgS2NvbmZpZyBvcHRpb25z
IGlzIFg4Nl9TSEFET1dfU1RBQ0ssIGFuZCBpdCBjYW4gYmUgZGlzYWJsZWQgd2l0aA0KPiArdGhl
IGtlcm5lbCBwYXJhbWV0ZXIgY2xlYXJjcHVpZCwgbGlrZSB0aGlzOiAiY2xlYXJjcHVpZD1zaHN0
ayIuDQoNCldoYXQgYWJvdXQgbmFtZXNwYWNpbmc/wqAgRm9yIHRoZSBDUFVJRCBmZWF0dXJlcyB0
aGVtc2VsdmVzLCB5ZXMgdGhleSdyZQ0Kc2hzdGsgYW5kIGlidC4NCg0KQnV0IGZvciB0aGUgS2Nv
bmZpZyBvcHRpb25zLCB0aGUgdXNlciBhbmQga2VybmVsIGltcGxlbWVudGF0aW9ucyBhcmUNCndp
bGRseSBkaWZmZXJlbnQgZm9yIGJvdGggc2hzdGsgYW5kIGlidC7CoCBBcmUgdGhleSBnb2luZyB0
byB3YW50IHRvDQpzaGFyZSB0aGUgc2FtZSBLY29uZmlnIG9wdGlvbiBmcm9tIHRoZSBnZXRnbz8N
Cg0KSW5kZXBlbmRlbnQgb2YgdGhlIEtjb25maWcgc3ltYm9sLCB1c2VyIGFuZCBrZXJuZWwgaGF2
ZSBzZXBhcmF0ZQ0KZW5hYmxlbWVudCBjcml0ZXJpYS7CoCBlLmcuIGtlcm5lbCBzaHN0ayBpcyBs
aWtlbHkgZ29pbmcgdG8gYmUgZGVwZW5kZW50DQpvbiB0aGUgRlJFRCBmZWF0dXJlLCBhbmQgc2lt
cGx5IGxvb2tpbmcgYXQgYHNoc3RrYCBpbiAvcHJvYy9jcHVpbmZvDQpkb2Vzbid0IG5lY2Vzc2Fy
aWx5IHRlbGwgeW91IGFsbCB5b3Ugd2FudCB0byBrbm93Lg0KDQo+ICsNCj4gK1RvIGJ1aWxkIGEg
Q0VULWVuYWJsZWQga2VybmVsLCBCaW51dGlscyB2Mi4zMSBhbmQgR0NDIHY4LjEgb3IgTExWTSB2
MTAuMC4xDQoNCldoYXQgYXJlIHRoZSBvdGhlciBkZXBlbmRlbmNlcyBoZXJlPw0KDQpJbiBwcmlu
Y2lwbGUgc2hzdGsgb25seSBuZWVkcyBhc3NlbWJsZXIgc3VwcG9ydCBmb3IgdGhlIG5ldw0KaW5z
dHJ1Y3Rpb25zLCBhbmQgdGhhdCdzIEJpbnV0aWxzIDIuMjkgLyBMTFZNIDYgZnJvbSBteSBub3Rl
cy4NCg0KSXQncyBJQlQgd2hpY2ggbmVlZHMgY29tcGlsZXIgc3VwcG9ydCAoYW5kIHRoZW4sIGV2
ZW4gb25seSBrZXJuZWwgSUJUKSwNCmFuZCB0aGF0IHdvcmsgaXMgYWxyZWFkeSBkb25lLg0KDQo+
ICtvciBsYXRlciBhcmUgcmVxdWlyZWQuIFRvIGJ1aWxkIGEgQ0VULWVuYWJsZWQgYXBwbGljYXRp
b24sIEdMSUJDIHYyLjI4IG9yDQo+ICtsYXRlciBpcyBhbHNvIHJlcXVpcmVkLg0KPiArDQo+ICtB
dCBydW4gdGltZSwgL3Byb2MvY3B1aW5mbyBzaG93cyBDRVQgZmVhdHVyZXMgaWYgdGhlIHByb2Nl
c3NvciBzdXBwb3J0cw0KPiArQ0VULg0KDQpQcm9iYWJseSBoZWxwZnVsIHRvIHN0YXRlIHdoYXQg
dGhlc2UgYXJlLg0KDQo+ICsNCj4gK0FwcGxpY2F0aW9uIEVuYWJsaW5nDQo+ICs9PT09PT09PT09
PT09PT09PT09PQ0KPiArDQo+ICtBbiBhcHBsaWNhdGlvbidzIENFVCBjYXBhYmlsaXR5IGlzIG1h
cmtlZCBpbiBpdHMgRUxGIGhlYWRlciBhbmQgY2FuIGJlDQoNClRlY2huaWNhbGx5IGl0cyBpbiBh
biBFTEYgbm90ZSwgbm90IHRoZSBFTEYgaGVhZGVyLg0KDQp+QW5kcmV3DQo=
