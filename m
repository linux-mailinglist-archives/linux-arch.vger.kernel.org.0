Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FFAD5F4D37
	for <lists+linux-arch@lfdr.de>; Wed,  5 Oct 2022 02:55:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbiJEAzo (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 4 Oct 2022 20:55:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiJEAzm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 4 Oct 2022 20:55:42 -0400
Received: from esa2.hc3370-68.iphmx.com (esa2.hc3370-68.iphmx.com [216.71.145.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D111357CC;
        Tue,  4 Oct 2022 17:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1664931337;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=XLAN+dSKt72kd1zLq0PQ/Fu1wd597+1uDBxMn8GKizs=;
  b=KW34+iu0bevO9rPYgA/ku5Bp9z7ZnPmtj+LNnKJxxG8y2Wqp3Mr3vGKc
   JDooD8OjHFNgPkZbzXfJ6Y2x2EQuCsHoCiRh0HpdSaS4mTHuOw7A2a7SJ
   sdpRSHtPm2WIhQt/luUp5phIHMfAN6uIHsH/X9fzap/W9Qja5yYkV10eS
   0=;
X-IronPort-RemoteIP: 104.47.58.105
X-IronPort-MID: 82000360
X-IronPort-Reputation: None
X-IronPort-Listener: OutboundMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: =?us-ascii?q?A9a23=3AHB+34qm7kAs2VsTbD5bn02no5mJPLRNUsHlM2?=
 =?us-ascii?q?KgCbOvbB7AAGqVkmqk9WtAdfNqzQtXZbZJUmPN6V+gbmD2tSCHEpIyiMY+Wp?=
 =?us-ascii?q?gNER3tKbLY4FITjoqEvdEMdfzw+sODh14QjV43unIVWHPI2tunUNlqDGqKx+?=
 =?us-ascii?q?w86my/HIXvzN5qS0Qa9DTXED3+DYGLtce0ChTE4ryyBN3wAFehDn41RUVzRm?=
 =?us-ascii?q?xVNlSUZgslWYg7lyHE8FGVsclS/NH3qTEwoZJiMKz5KL1flA7iLEu8wiuSqY?=
 =?us-ascii?q?2BkA80fdxnxVZG+XX3sdMNfqZAYW3smMWFj3ytHix3/w7i6xk/61B7FTTeFa?=
 =?us-ascii?q?ipCiWtRAFYUWHyW/aICovWN3/u6Jo20lyukB/w++FjdRz4f0bC5Uk3lxQBgh?=
 =?us-ascii?q?kXmvt/tLO0ljq60yGFapUzKY7lkQVvLDjuFJ9Kv1r26YhQGPVyU8Lban4Q70?=
 =?us-ascii?q?ZEZhY4FQWfgSYIJYyjz1Cc1bdJVWmclIAEbafQWULaI3rFOPEmx1nNVIuLaS?=
 =?us-ascii?q?PnalLNBZJGMKvhS5U2TrZNB/nJ3f0pu+V0o8S5ir2en5Kt4zLfD9BvwDPHLe?=
 =?us-ascii?q?1mHXwjCtorF4pz1FfTud393xSR3y+y62wHgzk5haONP3DmYSHZBDA2y6/IJp?=
 =?us-ascii?q?sQMf7h3UWgwIytObmGJjH3p1UbjFxjGArzC9U8PkMkoOUsKsXrc3OkaXjEbR?=
 =?us-ascii?q?3dVEkceDVAuN0F4RcR3RJAAA/Vz8hM/HwQHszKR6XZGBsChb6hMUj6KjKcD+?=
 =?us-ascii?q?ryYlK3rHBcLAqInIi+JgfORMXhOHV0MXwOAK3Ic0w2M7tzqUOaa01quBOX3a?=
 =?us-ascii?q?B/h1dLjYdqf39Qibb5VFTCVmjKPAv1lx+f/akjk4BPkoOI0xflaAUWfSKrx/?=
 =?us-ascii?q?G8Zv9GKTXrDOi4wz3R29uYKhlEtm1aPQB/D8+Ov2xpiYzasfkNcTZWjWtVXo?=
 =?us-ascii?q?bBGwIX1ajn3YorxSGHJOg6RcDN4bMr/Weydmk3ImLVVUQ1uKDmrc+5/urDgW?=
 =?us-ascii?q?UUuXUzIs6Hx+JiLRcU9FPZMwMk8zLsrP2NterIB9beWXWG0bKyJAGPIe3JwM?=
 =?us-ascii?q?SZBl2h4vGrU9889J3ZjxtEwqkUsvEqAAsmHMZ5NVPz2KvpHnFE7WivmDGUi1?=
 =?us-ascii?q?SawKzzwhNRbX0qvqvnM/dunkKnMTIC38CcQyt5zPOzEWoAf6GWQ6PlIki3D0?=
 =?us-ascii?q?JNMWicAOsXKoeI9erWCrRqjAHsDZQRxMYYhi9PpnmFDaukrqpuAolofGp39G?=
 =?us-ascii?q?4y/P42YYNVa5GQrIPaNJBC18G2fi/BjGdb8vGzSNtbDXuRk5iuzGPTdvi0RG?=
 =?us-ascii?q?2IQI/oNWT2Kde2qUKSmtp5ZP+RduiyapFw0G355UaovrVpUDTPcnOSpfFmm0?=
 =?us-ascii?q?uNqnItBCs758uKKQh9+e7VyWQa+E218ZAEqTUc6SZmAlXBJ2BaruY3NZW2Cv?=
 =?us-ascii?q?ksKLuS9wIfzYKpnBeKV023cZbx8LTLw6dd+Xaw8YFLKqB/1HJBUrjBnq/5gn?=
 =?us-ascii?q?k1wf8ky/co+ll/v0yPL0D4piwODJJUyPIpLUpnJQYoUlcbul8K3+bU0hK6rf?=
 =?us-ascii?q?tA/65Gq3hynGGIfLW45uMH+FGSgkEnVooDdhoHfEwmqOz9xI17AlgYcpTfWk?=
 =?us-ascii?q?kf8lz+0e3sWNqJsLbsUzLfPFfZo53ebDpQ6SUYtYnBMu6MWymDXn0NyPGxCD?=
 =?us-ascii?q?JB5HDw/7kVpOUHHu8lpQC8K/z4kYXfMNwn0lu2ZpZR92jg8Hvb4Ljw8j1vtZ?=
 =?us-ascii?q?Mq5ZEyeiQzNv4da6FIVQ1dkUtoFUZau23t2rXK85ovWLJk8bf0FI6P5BCerl?=
 =?us-ascii?q?w/4e7HB5HBr2XG1dxs+dEGvMFgqmO6VqvfbmVRTt0a+hz0d7+WemouCFNsuN?=
 =?us-ascii?q?PLAu5OgmfidMxxXltI+rzMm8vZeSK3kNOy2hGkBlULk8wEysgkVr7Cq7n6hU?=
 =?us-ascii?q?oZE+ApmUXQUXtDrpEE2UFX1aQrKCBhv0m/5O4ATRa3HE1eq/nzCjZT+IgdEP?=
 =?us-ascii?q?tKOvYW8mvh9JEQuVqptCKBmoJ9X0/VC3nYNCTennRFi/RsTE1QnqHu/XJ2aV?=
 =?us-ascii?q?zzqIT70NT1/U6W7dlcUbFWTCofuQprUNstNQzgpvPsAOtyoYOHmK2vM1P2BM?=
 =?us-ascii?q?7shAxa1NF9BbbeLsVAD9ceY23Ms5q6u5nAPOt80oTMlwE6kEUseyp+7qFkT0?=
 =?us-ascii?q?BvmhxnO2Mh8pcnuaf8gw4+MicwYZDQQrFKtf3ehFXp7ZsXVPLmeDkUZ240ib?=
 =?us-ascii?q?FibXQ0DBNIIW1Lg3YzFVTi3z42f3EE9V1Kg3EVXWNX6mgyQazP2y3VFuYCQX?=
 =?us-ascii?q?2LqfndXR0Sx5+l/ofZe4LgFLYHp4xhIvKwLf9RCJsPY7cr8m0Kokbu6/8JyA?=
 =?us-ascii?q?v8HkFeop8HNt/gRH5iAK6h1BIt0Aq2KsO8GgmNMYTHq2xt8YtEvWyOVhUWrQ?=
 =?us-ascii?q?xy/BjqhsonzYg//11RJTFF/iDdZl9QWCXXqtjVR/7YngEKnvb9p854q+RoVj?=
 =?us-ascii?q?QyqbrTSuRYLeJkHbNK24buzUVUUJPe7H5Rt1ThZnuQV8jzAAVd2qUGV+4sje?=
 =?us-ascii?q?5vR9Ez73XgkjWOflXQWUViDn8rfEEv2GuUZVxZdbCC6D9OgZMlAu7aAov0aq?=
 =?us-ascii?q?QNt3lklnHZPT/ukUI/w2KTBd5PsBkEk1Uc21xXOf5tC/aSiS/x+77MzBwvKP?=
 =?us-ascii?q?aQhxzg32PNDfKCkpS28bBGn0dmcZvx00awY4vndz32UutyzdsX79kXnnh19s?=
 =?us-ascii?q?fQ5p3duIpTxDawIeIOxo9hWMwEam8Slx1xJJiRlubOLXeZJcfNqOjdqj8sF7?=
 =?us-ascii?q?MZ2PuSFwrUMWmR2nDzj8q+TRq+qkFnSwZJHHyKffHulgDPSAD3RPUUFpIHDt?=
 =?us-ascii?q?ERYM1T4km+0oBbjOtVL/mmaam0FM8eTW6BN9YtEmHHT05H34q2lyEe3YrCCY?=
 =?us-ascii?q?RSFgrFSJPHqz/p5S6GYwoMjGvCu/ihQHGz7oZHk/J+utpesDRem/xFZDKEg0?=
 =?us-ascii?q?zCR3ECiH0qTBpOzxFxA8HtNIo2rPR59zD38IFiKqEhCLaOrgSjRcZPqilbZL?=
 =?us-ascii?q?EHHx04OWZECKogJ6i2TxtgQkgMC/nrG3fEpx2FJ00YP1PMHh8Vfc9VFQvk7Y?=
 =?us-ascii?q?0k27+xMw86hYE8075T1OkbZD3nARFg2qQrVCJDtKI1bq/HjtzP3tuQogyL1b?=
 =?us-ascii?q?wswR2QyoZAFd0NL0DpVVdZwgDqSp4L+BDWSShFSdnSKZsKO0or7Rtz0uU9aQ?=
 =?us-ascii?q?nicouCko1UDyMghOtZ9kbmMHrG9mvViXcC9rXczIzFwthQoOOu+ZICz0TSVM?=
 =?us-ascii?q?Teol+Rj82BzTvv29DbhPicTSdYY/kUy5S4afIgWCWcI1HnXO3Pkd4unWaKV/?=
 =?us-ascii?q?YMgOjkdh76JYjSOMv6gjoKgzZG8uEAfYoqpw9t+FeRMGb34OlJ2xkQ8zZ4Po?=
 =?us-ascii?q?zI0dF8OD4t6za0LH26/EbJ5YhGCDieN6JeQdOJ5yZZ5oQJ+lZpjfDKzD3x+c?=
 =?us-ascii?q?S9kOTZF5AXNKExxdWwGwCSuKmv2HdpZ5j5OMW1EMcF9O66BZsjzzmJetj0z7?=
 =?us-ascii?q?S0mp+32MKkbdKeSAnp5251EpJlpO5pUSDOkgw4oLSYaqOmIviFC5J1s8aM6z?=
 =?us-ascii?q?maHkAdRFxOks1gipOFBNhfXZOPvCt9xdVr496Rhu4uPrqVDkcQozBu/biCgI?=
 =?us-ascii?q?/Th8zwkEwyxeJ/hE/djXuaxAtw6Kokb75zlj3VbmELjaA5cytUptxPEpwEK2?=
 =?us-ascii?q?m3JyAwIjv5+c09D92m9sqtCrQ+E25/CNMMPV7rpecAbyGWCgoP8p56r5bCN5?=
 =?us-ascii?q?EEwGEJb0eSvhFjtDT3n7gCYWoVX7DjQEi3yCVgsJJS1WwQL1UOpT0U8Gz+tv?=
 =?us-ascii?q?2Qv9C+XQNFtm2fYVM7T6+NGIErDWhXFUGL25LueI5cIXLwdUjR30i6R+JN+r?=
 =?us-ascii?q?TUlm3ERDhIy8KzLWzho4QUHtxzYdmNtkOVShuU3hOPLltIJSpi7zgo/S79xm?=
 =?us-ascii?q?uJPJBriWJGAjVNPfUsuN5d2poKzymI1NafkJiXdOa5CkqQF4okwNaFL9NKmG?=
 =?us-ascii?q?hTlYjhS+nud+Q2l3ZqklTALybh8ZZEBvZnXGIcl739R3I0pr+w2nNTM8+79Y?=
 =?us-ascii?q?1Zbeiq4BBS5alyn6Lgj3lC6X1EfVZdyFeOtMzqT7rs5EjGMZSXzh0q0AyBXu?=
 =?us-ascii?q?HItrtFEwy58bEo7g6aOiiiRN0cNWLHCajgtPztVWJKRGuJlGbCrbFNJZGpPW?=
 =?us-ascii?q?2ADd1DntmYgxYfy8LbfWFMc/xausn2Qs0+d4DGGghSKcKS2R8K3lDTGF1/Ff?=
 =?us-ascii?q?gDanZ73tn8kBvCXb+a0zlLUvgUJn8IBfltyhHUA/yn02pvLiIshVDSO8yB9a?=
 =?us-ascii?q?Flug4vTRWRD6Dsxs0t7f9b3rJwjAkSC1YUyxuN2fnV6vYYEeEPSgFFSVrv/E?=
 =?us-ascii?q?JHTJuA4R2MBI/MvKfDzLC5X7nWFW6ScJnf3XTQr6UCwkQrvlGxjcfyTX5w93?=
 =?us-ascii?q?I0wJECYMcyqSQVLkQRiTyEz0Wbe2OaQQRor4NVzElf1jHw9RR8iahGopUQg6?=
 =?us-ascii?q?ALHzZ/4o3IRVQzIoRhDFgvBBex40rXt+knCsrWZ4UFS4ZTKDEdMQR2L3HOQP?=
 =?us-ascii?q?dBG7bDSkecof3i8m0A/SSFDHQT+0cyyOXWbIaBoa4QAooGiufWx1fx94xiqP?=
 =?us-ascii?q?Kt4nKCxoWCnVww3vHj+WkX5NiykbPziRie/QU0wmuuCd0WiSfTC7SAkf7TpL?=
 =?us-ascii?q?x+jXTzGzwi/5bD6DxDOVM0nh4QPbthJFnHOI26tImUWo4tvEasTaUCXRD31y?=
 =?us-ascii?q?8+09r2RBlWpjo2udDyW1Ld9ZJuXBDxxcolonigYwqq2/A907xDZYdhue7A5N?=
 =?us-ascii?q?5wWRsgNr0U1tCOEc6OedGAzV8V1CZNsX3QBgH/cyBhL/2snn7jzUzjEFMq8E?=
 =?us-ascii?q?U+LWillXoHXKct2qIsXP1xb4Hv+oVOCGASVGXOXD4nCHNQHo4DQPJGkPUuWx?=
 =?us-ascii?q?oTq45w7KpOjhBNv83tCvwEuZXYHAI3x01ad+zNdN2bCTeQ7m+sW2WUdadx9Q?=
 =?us-ascii?q?kSQD49W4pilhw+GocBuxROyqCcmocCgA8rwaeELYTUAIyY76bi9LVaMPo3Yq?=
 =?us-ascii?q?YrFHTYOonIvdXeeiBELG75m2Fw5/osdmstNmYKn/sUWJ8DrpAA62RV3MiZat?=
 =?us-ascii?q?jnLUpYCO8g3kN8TOWNnDOhdv7NuTj9lQrvAoDwmYC8nez64S2rj3UHRRzhZg?=
 =?us-ascii?q?HfPIVQf4TFzfnQtnk5ptcjhQwcJuLnTsYycQlvudp0trpHBJS4ZZSm0HGDmU?=
 =?us-ascii?q?xka1igw5UFp7IbCWsrnPsrSr1MuokOPxRUv+tmgNY2ghnidGUOE098zV81hr?=
 =?us-ascii?q?lUL19iP6Orri1fPznpj6rO8PTRKJiiFYQPfP0JMIbecdOje1ZJDfcq7x5GPE?=
 =?us-ascii?q?fUgjr5pyDSKULvGrlDimz8SUpem/aCSipkDCAsrPK+gXJm45zMvyRsnVbYf1?=
 =?us-ascii?q?X5/3eD4y+Z5sMFJuMpEEc00weVPohq6BY9P7MlyG+Au5uVQiVhPP5KB88Jb6?=
 =?us-ascii?q?GfmT9XY5TsJLBhHKQ=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.95,159,1661832000"; 
   d="scan'208";a="82000360"
Received: from mail-dm6nam10lp2105.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.105])
  by ob1.hc3370-68.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Oct 2022 20:55:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gYHL4M09/yFxQKZbIRniDIjdH/0Xz+2tsVmNpQHZPJW4j0l6qCnTk8iymzDesqtS2vV2NTi8F4QcKcQD44zj6/JKcsewQzhjpL3BSiGB3GSt2YAs9OloQMr8hIpvDYH3vZIjkeE/y41cdeeS1kr719eSjGXJ+okWP9OI1SX5ujNuvArbTlK/e1M0e1wnDU4jnbNeCpwjQXuEYW0UGYZROtJ2mA68CLdGgRkZ3vYiH+066C9yr6NHwn4dAO2A7t4duHDJXoL05juf4x5LigAvCy+Y0lNdm3ldiMjauBkCDoEf0IQuVlDCHKOplBogRms1gKFOtt1C60y8Z0egcqCOyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XLAN+dSKt72kd1zLq0PQ/Fu1wd597+1uDBxMn8GKizs=;
 b=UyBg38lIm1ee6Sxptpo6coXnlanCv5j2OAn0NzcoiJeFdyZ7pvWW/RbV4ePFTrRSjHrkoQxdsKRZQP0KmsD/+nF42xG/7DzCxKW/GgRGfw8DiLT/0kJ4e4c4tpN60n4t8VLHtZtjUz758l3+QsCKwXM/oOHlhyFrnikmKq1BWbpAIKBrVXx74LU0py8fYxxVy9LvEe9KMK5cuoZtufJWy5CqS00CrdUTInf6HPllauOMGKsw/qZjmUx0H6LQ8XOb+f2g7ehjkI9X1Bl+LM9S0e655CeCLCF6vUjqXznsd5624ll5hM4xM0ThgGZtySQ1wgL1fiJExncvh4CFY4i6cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XLAN+dSKt72kd1zLq0PQ/Fu1wd597+1uDBxMn8GKizs=;
 b=p6iZKCSHm5llVWasSUBIjIDLwZoy8ICTxMnoA8ziw4lVuFfbrVc3nUBYSRNOQiuseINLyjkbc1FzXl5q5Y2x7QDO1hK1JFIjoX7YIoBOAQFcr31m2cNkfVUCKSBXvfWJc6u2aM2OVPRT/6t0N1Hg/KNUJlhVTJ2QuYrURL6DYRc=
Received: from BYAPR03MB3623.namprd03.prod.outlook.com (2603:10b6:a02:aa::12)
 by SJ0PR03MB6423.namprd03.prod.outlook.com (2603:10b6:a03:38d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17; Wed, 5 Oct
 2022 00:55:28 +0000
Received: from BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::988c:c9e4:ce0d:b37c]) by BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::988c:c9e4:ce0d:b37c%4]) with mapi id 15.20.5676.023; Wed, 5 Oct 2022
 00:55:28 +0000
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
Subject: Re: [PATCH v2 04/39] x86/cpufeatures: Enable CET CR4 bit for shadow
 stack
Thread-Topic: [PATCH v2 04/39] x86/cpufeatures: Enable CET CR4 bit for shadow
 stack
Thread-Index: AQHY2EQCe390nlXEcU2qBASfDXYcxq3++ciA
Date:   Wed, 5 Oct 2022 00:55:28 +0000
Message-ID: <da26db09-ae80-f076-388f-9d5884f67b23@citrix.com>
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
 <20220929222936.14584-5-rick.p.edgecombe@intel.com>
In-Reply-To: <20220929222936.14584-5-rick.p.edgecombe@intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR03MB3623:EE_|SJ0PR03MB6423:EE_
x-ms-office365-filtering-correlation-id: c5c3953f-acae-4562-df6d-08daa66c4bbd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TiLYO9MSRs5e5rmiC7ypW0YOl32w2Qht8zbDgwDdJJ3AYwY8PRaV/4dQjB7JSRgX6bpjcY4XsOBdhexOom959BqQEppnZL+B8jmqUnNFPJZmxsHEEqs1vNBG5oKr1r0nPFSTck/oEUAhn88WIjGw1OM55Wncq2iyhjZfWZ5ae71U/JSkdbmS4lomVYN3n1T0XD3Ed73P59P7KtRrAH5rFuR7Z2QUatXixk5Zrw0iP/IvIKt5nQYTtVQ5e20ahkzrzg5hx9BdKtpY+yMdGUPfSXtsWCWwozz2SNMFiLf0zSy72wcNn6T8Y4sT+6GMGuWN9vbvYsjxYi6+IUxOU7GCHx8+XaNBRenS6opkhtE0iKkpoy1ikjf9T6LIsjewQdzytmfZ5ecq/TzfxFQSZmD5XCW7hqy7BHuvynEknDg2phzKkWT/mZKn6VkjTWthfPJHtb7K0s/+U/rYhdUhqN0myYsJ6IJlBduFQD1DY0mmO2rlTBgBlT4/xYvyjCO3D6Z8w/1Vd/IektPeRMEguoWupboOPa1yKpvzON0zyO3Vl3IOCxnIgWEUjwr1/VQJTCfe58HL+o2S0Qlt5nPuIGU2L/y1z6yu8n3CB8K6OMYtlT4W154DElma+KszGMTyV2ep8o4dQQA1J8wp4DOw98YdS6iU5SftzNmQPCei4BEfasJA3m/LnKrNH3V56IeEZX5iFMPmS4DXlqTb+k4GV+3TU4JoS+mKWzBfzP1VnVYjTmQu5ZJaxz1HQYUiUv+bTgODGFuI+7LLMOeKLWyNqbWSHqoWt9IRbVQ2u6SwiL0xSR3OU477TemFxHr7NsaWJgyuY+Hz06abS6/jaQAaj3mAgB2vY9u3iEdIBOwbi0s4QJk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3623.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(39860400002)(396003)(136003)(366004)(451199015)(7416002)(31696002)(110136005)(86362001)(316002)(66476007)(921005)(7406005)(38070700005)(122000001)(31686004)(71200400001)(36756003)(38100700002)(83380400001)(64756008)(2616005)(186003)(53546011)(6512007)(66446008)(6486002)(8676002)(26005)(66556008)(66946007)(76116006)(41300700001)(478600001)(82960400001)(5660300002)(8936002)(4326008)(91956017)(2906002)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WVhqZjdLSVpXeFNkbS85bU05REJWSE56QWxWeFR1UzFHN1ZUNWtId3dYSXZW?=
 =?utf-8?B?b2NUZUl2TFU4SGkyM0tXSzBuODVjRi9mSnFhZjMybTFReWFZREt4YnpiN250?=
 =?utf-8?B?bDh1Um83b29mMXRnRDJwellray8zb0J5OURvSWhDL3ZVOTFlMk5LRGVzN1hK?=
 =?utf-8?B?ZWV3R1VkYmExTEgyRGd5bGZpeVdRNFEyakVQVXFVaERIbUJvcldwRmFsUkkr?=
 =?utf-8?B?b2txT3V5aW4vajRGZi9TOGNyeFhIMSs2RDBYQzNJRjY5c0ZoR2w0V1VPc3Fn?=
 =?utf-8?B?TmtPVmQ5MGt0U25pQnAyMFMwelA5dXU0Nm5FTHJKb093dTBMbW84emUraVYw?=
 =?utf-8?B?d2hTMjlOOWpUbzZOQmhTZmQzSGVxelpVM2Ruc1JhNVNVZ3BGWm5qZkd1VzlX?=
 =?utf-8?B?d3RGRVdCOUxDR2lVR1VlTTlnMFhNZVNRZy9xQmVGcVk4cVRDVlpZcE51NmFX?=
 =?utf-8?B?TzVWS3RnYkU1RWtqU1FwRmxKYUE4bXdhcENCbGJwQ2daK205MGtaR2VJTitR?=
 =?utf-8?B?MGovaXkyWkpQYTZaR1Fvc1RFMGcvcGMzYk1xQndrUkNreGFvMFZpRHlxSHE5?=
 =?utf-8?B?N2tiSkhac0V4YUhIVGM1QWhHbTZGSUpFY1p0MnB4Ui9PTGF5SUYzQzlFRzU1?=
 =?utf-8?B?Vnp3UCtYZWNUaFg5cVRqZngrRzVyK3NWNHJnZjl0VzZQOTFOVmJpMGM3dHFm?=
 =?utf-8?B?U0l1V1NzZ2dXazFDZGRuOXRGYWwzUVFCNnRzU2JQc1dSY05RNWU5VDBDY0Zr?=
 =?utf-8?B?TEJZL1lpVjF0YUNYODkxVmwyR0tGYUpqMjF6Y0NIYWY4ZEZlNTEzM2MwVVBR?=
 =?utf-8?B?Uy9JMzRFb2ZXTHFEN001NXBQdWRUczZueUl2aGtpMkp3Z050Q0wxRk9DMFhK?=
 =?utf-8?B?Y016UkpIYkxpbCtTVGlyVlVzQlh2VHVoa01iMndhaW1ZRGxLYit6NjcvTjh3?=
 =?utf-8?B?RUhlby8rY1FPUXdBbE54QVQrVnB3Nk8ybHRPQXhhNzFDc1dqSHRSdFVxWHFM?=
 =?utf-8?B?S1FWWnd5bGJ0K1dtNi9NajI0V1FyZzd0SGwrdE0wbW9kaDJtNHRTQWcwUGlJ?=
 =?utf-8?B?MFhSb2NqMUNuS09pd3RBeSs4VzBuSDFKMWFjU3M3dm9Cbi9OcHIvTkVkdXgy?=
 =?utf-8?B?Ym1OS2x1VHNMdjdzR3RhM1kvRVJhN2dCdlZTOUVmdEhsT2g1Uk5nbE9UN3Jm?=
 =?utf-8?B?M0o1VkZ2azJQRkFYRllhS0dmeDdlWVhLb1FvRzBIK3Z6WkhnTC9oREZpdlFz?=
 =?utf-8?B?RitCQkQ4R1AvQmtSaGMrTUxicXZid0ZPSGMzbmhwZGdPWkNHVmhLNDRsYmZJ?=
 =?utf-8?B?UXdSUHh2T2hNdnoxV05nbnFzT2toM293bmdKUmpJZEliVVdyWWxFeXY5L0ls?=
 =?utf-8?B?TzdxZ2dJTkFNYW1MdCtyUThNQVRZcUluV2lzOE5NeVh4Ym10TDZ0Szc2bitq?=
 =?utf-8?B?bjRKRTlHcURpb3RhMTN3ZC9QMndSdk0xMlVVUUlNclJBdFdldFpOZk10ekNR?=
 =?utf-8?B?L0tmUjEyUDdpbGx6RDZuUkRGZlZRVmZlR0RTOG1jVTlIbXRSMFdJR3N2RUlR?=
 =?utf-8?B?b01nZU1SdGdpUWlLaVBqMGlvTnVXd1BlOEhidHliL2M1OHRnbkpySDhiZmpJ?=
 =?utf-8?B?MUNnazhhQm93bTE2dVMvQUtBb2ZSTFhXcUdQTTVDYWdxaXN1dFpCcXhXWk50?=
 =?utf-8?B?MDAyMEtDb2Rodzk1RFJ0TE1Pc1I5dFRHcDFEbEpwM2o3YUloS0tydjczYkw5?=
 =?utf-8?B?Skt4UHZlNEx3Z3lLbzlXaU5jejZHaklTNE9TOU9Rb3NIS1YxMjBZSmdTSzVM?=
 =?utf-8?B?SkxSSDNSMmxzVmZQdFlPODRlYUZRRG16RUkzd25jOUI2enhmRGdIUXE2clpB?=
 =?utf-8?B?TDFGOXpRM2YxQjNTdEZKamhhc05ibWNxMHBTNUdBTnVaQTJGdWx2TWV1L2I2?=
 =?utf-8?B?N3RZR3JUZWxCTEhBRFBzaU5rM041Q3dnR1pTK2htYWozenBuWS9UVEVDWUFF?=
 =?utf-8?B?S2JwQnNtSXZ2V0Q2SDZhajhKSXQ3WXRXcGlrMzA1RVcxbU01VTc3d3Z4VFI4?=
 =?utf-8?B?RU9vbmhmZFE3cDRhOEFDVVJnNHp6THJ1S1YwT081RjJTc1F3RVo1aDZ0OG44?=
 =?utf-8?Q?W28uUBYiTS8UamTjhXDrt8E3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0C6022A57F24AC489F41CE22B3148317@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?SzN3ZGNIVklCT2FhM0VPTU9NbHZML0xjbk9mV3Z2a3VvS0U2N1c0eUtpSWwz?=
 =?utf-8?B?V2tIWjdMV2drSFJOZGFFU3Nkb1Z5VTRYVmNHcFFCT3NwanhIdEpzaGhKNmpx?=
 =?utf-8?B?Y0RrQUJSV3IzR21UUWhEaW00ampqUDhrcTd1VEdJTmZGc0R1Vkx1Q0F3bGFW?=
 =?utf-8?B?eDc5UFUvYjBJTFRoK1JPcHp5QXFJQVZTWnRCM29FQjRSb1A0bHM4NnNZcDNP?=
 =?utf-8?B?TXVxRGowVmp5MEYwU0RuRUtBanIySnA5Qk53ZGtkM3VYK2lVNThUbHpKSkpz?=
 =?utf-8?B?WVNiTGFpOEVvQkszaDFIQzd1bThpVDFUdlRBdTdEN0JjT0xweXBLVi9aNGp6?=
 =?utf-8?B?VTJ3bktSRGwxeERTSUFVNFZ6S0ZGaHJXc0VteDZKS0NUM25hVi95TkY3RCtJ?=
 =?utf-8?B?Y0t0R3ZyZXFndEtpL2pDbCtqUExLejdqTWVrQXN5eVZKN0FveGVKMTdjQ2No?=
 =?utf-8?B?ZXp3dCtaMTZMTzlEOGo0NW0xblJ2Z3hweDhqSTAzd2lNVENlSTZxZjYvQm8z?=
 =?utf-8?B?YUhlL3ZGZEd5VjIxT3UyNVlxZS8vc0M3aWNIVHBHL1Axb0tWMmtoSXVFbHJN?=
 =?utf-8?B?ZS9mSzZlNXdrbnlJSFBEaVphMzZnK0cwVVdpRHQxYlFtK25UUzlDMWVmVjdB?=
 =?utf-8?B?MG9kdXIxTGI1dVhLNUFZK3dFVkx5dEZrdk1zdFgwdnduTzladU1JNGZ1ZTVT?=
 =?utf-8?B?bTNtL0J6ZnhYN1ZueHBwKzFlMjlQZzJMeG9LTm9iYnYrbjJFS2VLakx0TlRp?=
 =?utf-8?B?OW1wZDhTQ3F1L002V2h4cFU0UU91YkI3VFB1blVnalg0Y0pKVlBiTE1yNFhl?=
 =?utf-8?B?NlZpRFpiZkRsZGhhWWZweUJFQlFaU25LZUp2V05RbGNCL0pkWm5PL1RaVi9y?=
 =?utf-8?B?N0pSWGU3RkRTOUh3bHFTYjc5SVdFd1MvaFJIR0xqRkxEaXNhY2t0QUQxODA4?=
 =?utf-8?B?TG91dGQ0Y0dkQmhBWVF0cG5yUWlzZFVqbURFK2UyZXhZTnBaSnVCOWIyYnJD?=
 =?utf-8?B?UTRpMGVOSVFFNU9CYmdLUDZ5UkVBSmZ6WG5odytGMGpIK3I4cExiVlJ3STdV?=
 =?utf-8?B?M250cWRBUDlkVGovRXJHbVYwdGpjYjFYVG9ZenFBTEJpdExydnBKcEZMMWFu?=
 =?utf-8?B?TlA0ODd6ZzdtR2ZGNmx4eG9TNzRGbEFObjVjSGJwL0VCcyswNUMzS2wwazVU?=
 =?utf-8?B?YTB5TGFLdDV5QVNyZ00xZnhFMFdNWHdiODc3QkZYUHZ0Ym5qT3duTDZsYndv?=
 =?utf-8?B?N1lONkJmUG5JaTJDRENsQTZKbjZYeFdKMEs3UlNGOEQyYk41UWxYYlZmOEFh?=
 =?utf-8?B?Z1VBK3NJT0ZDcVpJZWU5QUdmU0F6a2p4MFdLQWcwcndERkJ2dFVtalZWcXFw?=
 =?utf-8?B?UWNIdkFmOUE4TWhRamttUkw1TzhGWit0OFlOckhpZy8vcDFpYUFsR1IrdWVi?=
 =?utf-8?B?WnZTdVRkOTV4UExEdFlaTFRRS0Rnb2g5cTZvKzhvaTFYbDlwMkZLOXJNMWpy?=
 =?utf-8?B?VTgxYWJKR0djZy9UVmYxeVZGU0JpaEh2UmYvSjY3SzJxc25Qb1htckdQb2xO?=
 =?utf-8?B?djJ1b3hvZm0xS1VlOWJ4bjYwVXBBV1pzS2dhenNqUDNTRThWb1B3ZklLUkFV?=
 =?utf-8?B?eFdmeFZCYWhyYWtIRTVjS1I2aVpsMEZuanVJSXkwNzM2SDhwVFNYOHdDcElG?=
 =?utf-8?B?S3Z6UmRUV0wxWUxiQ1E2VnVJUmpkMVN5VkxPc2Y4bGE3M3p3OFRIZk10Wi9Z?=
 =?utf-8?B?Wk8wVWx0TTNKaWx5VTcwL1cwdktKdzQ5cUZKdXlSTXdSQ3Qza1ZpanhRMTVZ?=
 =?utf-8?B?Z1VveUJiTUM1YjViUUhwYStQMU0xNXpKWC82UDloOHJXaktHWUZtMlg0NmpF?=
 =?utf-8?B?TmZ0Y1F5Ykg1NFh6YnhCUXpUQkY1S0ZJYjVEemh2RlkzT0FocFdxSFF2dEVI?=
 =?utf-8?B?dXVIdnM0citoNSsvN2lCdU1pb1ZXdnhOTmpyU1Z2aWVjd3R2QWtMclNhUEFj?=
 =?utf-8?B?am9TczVLSFRIbDVlL01UaGR5Zk0yUEtyTkcvYVBEQVZJSUc2enpDOW15MkN6?=
 =?utf-8?B?b3NobFFTMTBrVnA1RGZZQ0VLM0d1MWd6cWZOL2tKcWZ2QzBUTTVkTHF5aVZM?=
 =?utf-8?B?WUQ1YnNqNGZIOFZuU0lqMmZBNVNuUjdZNnhqQXJRQ1c2dW9Ib3d0L3BSVi9X?=
 =?utf-8?B?dE5LUTJTdXhXNDBUdlByZGdXRmQ2UEVWMHBmNk1DclAxKzZsZWhOK1NhMDQ1?=
 =?utf-8?B?dnB5ZXZnd2tSM29tUi95Ym9NbHY3RUUvQUNxckxNNzg0ODBRaHNsNjFLSVVK?=
 =?utf-8?B?SytlYjNlR05ZWkJYamtBWjBIa3dnN3EydmVlZUUrdGdTWWgwbzB5MGtwVVpa?=
 =?utf-8?Q?+TPCgNuJ2CL5yC0fZxBnAkq/rqWe5Pw+WGk7YCsAx2951?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-1: z0gzvrJ9OXHLHtpriQLUdxL4Z4XutNSNBpJgbN5XjDLuA+KJjvqZwJnqsAiIjXzLNvnCZtp5pxzOo4uQmLQaA1N579oZlv4zsi6XXq4eae2SG2Sy098FAWKdY4enjcn/Msd2REfk7VTAYdN2QLZyyPCtSGjfHFiI3yI=
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3623.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5c3953f-acae-4562-df6d-08daa66c4bbd
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2022 00:55:28.3291
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o1s2I5li4Fffrd61AnW1B/qO3QoiSkUSZPFs11FuHBKSQ8cCGbVMes+aXQcirEiRp3aPeA4C1K3S9j4M0F12LuIDJC5mDKzm5Q9n2+1iXpM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB6423
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gMjkvMDkvMjAyMiAyMzoyOSwgUmljayBFZGdlY29tYmUgd3JvdGU6DQo+IEZyb206IFl1LWNo
ZW5nIFl1IDx5dS1jaGVuZy55dUBpbnRlbC5jb20+DQo+DQo+IFV0aWxpemluZyBDRVQgZmVhdHVy
ZXMgcmVxdWlyZXMgYSBDUjQgYml0IHRvIGJlIGVuYWJsZWQgYXMgd2VsbCBhcyBiaXRzDQo+IHRv
IGJlIHNldCBpbiBDRVQgTVNScy4gU2V0dGluZyB0aGUgQ1I0IGJpdCBkb2VzIHR3byB0aGluZ3M6
DQo+ICAxLiBFbmFibGVzIHRoZSB1c2FnZSBvZiBXUlVTUyBpbnN0cnVjdGlvbiwgd2hpY2ggdGhl
IGtlcm5lbCBjYW4gdXNlIHRvDQo+ICAgICB3cml0ZSB0byB1c2Vyc3BhY2Ugc2hhZG93IHN0YWNr
cy4NCj4gIDIuIEFsbG93cyB0aG9zZSBpbmRpdmlkdWFsIGFzcGVjdHMgb2YgQ0VUIHRvIGJlIGVu
YWJsZWQgbGF0ZXIgdmlhIHRoZSBNU1IuDQo+ICAzLiBBbGxvd3MgQ0VUIHRvIGJlIGVuYWJsZWQg
aW4gZ3Vlc3RzDQoNClBvaW50IDEsIHllcywgYnV0IHRoZSBvdGhlcnMsIG5vdCByZWFsbHkuwqAg
R3Vlc3RzIGFyZW4ndCBpbnRlcmVzdGluZw0KYmVjYXVzZSBob3N0IENSNCAhPSBndWVzdCBDUjQu
DQoNCkNFVCBpcyBhIHRhbmdsZWQgbWVzcyBvZiBjb250cm9sIGJpdHMuwqAgVGhlIE1TUnMgY2Fu
IGJlIGNvbmZpZ3VyZWQgYW5kDQpjb250ZXh0IHN3aXRjaGVkIGluZGVwZW5kZW50bHkgQ1I0Lg0K
DQpUaGUgNCBtYWluIHN1Yi1mZWF0dXJlIGVuYWJsZW1lbnQgY29uZGl0aW9ucyBhcmUgQ1I0LkNF
VCAmJg0KTVNSX3tVLFN9X0NFVC57U0hTVEssRU5EQlJ9X0VOLg0KDQpUaGUgV1JVU1MgaW5zdHJ1
Y3Rpb24gaXMga2V5ZWQgb24gQ1I0LkNFVCBhbG9uZS7CoCBUaGlzIGlzIGJlY2F1c2UNCkNSNC5D
RVQgaXMgdGhlIHBhZ2luZyBjb250cm9sIHdoaWNoIGNoYW5nZXMgdGhlIGludGVycHJldGF0aW9u
IG9mDQpSL08rRGlydHksIGFuZCBpcyBhIHByZXJlcXVpc2l0ZSBmb3IgYW55IHNoc3RrIG1lbW9y
eSBhY2Nlc3Nlcy7CoCBNb3N0DQpvdGhlciBzaHN0ayBpbnN0cnVjdGlvbnMgaGF2ZSBmaW5lciBn
cmFpbiBlbmFibGVtZW50IGNvbmRpdGlvbnMuDQoNCkknZCBzdWdnZXN0IHNpbXBsaWZ5aW5nIHRo
ZSBjb21taXQgbWVzc2FnZSBtYXNzaXZlbHksIHRvIHNheSB0aGF0DQpDUjQuQ0VUIGlzIGEgcHJl
cmVxdWlzaXRlIGZvciBhbGwgQ0VUIG9wZXJhdGlvbiwgc28gZXh0ZW5kIHNldHVwX2NldCgpDQp0
byBlbmFibGUgaXQgZm9yIHVzZXIgc2hhZG93IHN0YWNrcy4NCg0KSXQgaG9wZWZ1bGx5IGdvZXMg
d2l0aG91dCBzYXlpbmcgdGhhdCB5b3UgY2Fubm90IGRvIGFuIGVxdWl2YWxlbnQgcGllY2UNCm9m
IGNvZGUgZm9yIHN1cGVydmlzb3Igc2hhZG93IHN0YWNrcy7CoCBJZiB5b3UgdHJ5LCB5b3UnbGwg
ZGlzY292ZXIgdGhhdA0KZXZlcnl0aGluZyB3b3JrcyBmaW5lIHVudGlsIHlvdSB0cnkgcmV0dXJu
aW5nIGZyb20gdGhlIGZ1bmN0aW9uIHdoaWNoDQphY3RpdmF0ZWQgdGhlIHNlY29uZCBvZiBDUjQu
Q0VUIGFuZCBNU1JfU19DRVQuU0hTVEtfRU4sIGFuZCB0aGUgdmFsaWQNCmNvbnRlbnQgb24gdGhl
IHNoYWRvdyBzdGFjayB1bmRlcmZsb3dzLg0KDQp+QW5kcmV3DQoNClAuUy4gVGhlcmUncyBhIGZ1
biBpbmZvbGVhay4NCg0KVXNlcnNwYWNlIGNhbiBwcm9iZSBmb3Iga2VybmVsIHNoc3RrIGVuYWJs
ZW1lbnQgdXNpbmcgZmF1bHQgYW5hbHlzaXMgb24NCnRoZSBTRVRTU0JVU1kgaW5zdHJ1Y3Rpb24u
wqAgSXQgdGFrZXMgI1VEIGZvciAhQ1I0LkNFVCB8fA0KIU1TUl9TX0NFVC5TSFNUS19FTiwgYW5k
IHRoZW4gI0dQIGZvciBDUEwgIT0wLg0K
