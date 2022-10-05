Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54B075F4DA3
	for <lists+linux-arch@lfdr.de>; Wed,  5 Oct 2022 04:17:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbiJECRl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 4 Oct 2022 22:17:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiJECRi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 4 Oct 2022 22:17:38 -0400
Received: from esa2.hc3370-68.iphmx.com (esa2.hc3370-68.iphmx.com [216.71.145.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6E96474C7;
        Tue,  4 Oct 2022 19:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1664936257;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=xobPFK6EeIsuyDlCQtFNL9N4kCXkF7EhcvqROQLcfV0=;
  b=aYkcm+tXRddkN3kAXbWeRvcBGHsAbYsoU1P977JdnoxiGR/LD38TfCQf
   JFCli9zivojbHxXsyijMxG/Q+a+GLAJ3k+WnH4cILXUdH5RsnXDtlOzMu
   49XhNeKwfOAvlxXmDjhScmxapAb1juZsF3c6IZ1P7yKRl2gC7IGYR+Xch
   s=;
X-IronPort-RemoteIP: 104.47.55.105
X-IronPort-MID: 82002936
X-IronPort-Reputation: None
X-IronPort-Listener: OutboundMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: =?us-ascii?q?A9a23=3AG2d/FarxwuyrSIhn7AgXhOE1aHFeBgzWbkVuM?=
 =?us-ascii?q?Zf8NTMUvWFhRL0lAxOYi7zXOP7vAUf+wpgaQVJeXPr7njGl+m52ucKsds7a9?=
 =?us-ascii?q?Ni8pZRet0FhEgs8AbwTlQLuxJxUEpxBTyadSSNvv78S2LZgQcdj/F7tGAITG?=
 =?us-ascii?q?nsPHlkR5kVvtGtg8zf3m0yWO7edQWfBMcO9TodXvrRgF0V47rroIjOnI8OWt?=
 =?us-ascii?q?ikwfFWtFyYUSQGnLwWfIPvTFUMaOyPGQWiamvtwLIW29+Pnmr3NgyVvkoSrY?=
 =?us-ascii?q?OFmLdIB35VeEGKtrbmmWCIQ/YBhFd1z8IjacDzztN8Oz5D7F0WY9oOh0i2E3?=
 =?us-ascii?q?CKFfHeUextOdK6a7pybwxX++HYH0pBTyRH2zSTF1DjBUCAcgZzzDHbSfwVNF?=
 =?us-ascii?q?7zCWBItNblvJe7aySTKGb/55M3HF1vpUlO6mvTNCpaF1tkQj2Iepfq6DaqXu?=
 =?us-ascii?q?ri3KVbz9pF/W9Iig7uELgW9V1DWPy2mNMGizA0cmnn7VEFWWjwmOaTXD77SS?=
 =?us-ascii?q?jnqsucZ/+uFrTemLvsH7Jk8PjplXgSQdpEew1I9z4rOz1dQthDIMb7bu7qsf?=
 =?us-ascii?q?bKNFleXLIwxlYoRHW4XIto8ANxPvwy9UoGeYAkcMK8IciMZrLWQfkLLNQiIv?=
 =?us-ascii?q?HAV/yAVxi1p3cef4arQm5nej/tM4XY9MySzh26FMgRtszihmAwb+9CnFnobO?=
 =?us-ascii?q?DwbWAGTNvF2wuv5srEE9gNUxjukGvBRKcMpq5UiwvkKul8r7plBhEhjMMYp8?=
 =?us-ascii?q?NeQC20ysIeESYr9UWAav6XzElrGjKixXgpcVaVIl8dvdmDpBkpW+O14Sz2Gw?=
 =?us-ascii?q?rpm0D89nI2c/TofDrxiPqaucoVjI9CgVZt3YqCnWKFVrHll47mfySdGEX0ZF?=
 =?us-ascii?q?Jb1Q8V9Ci/hLHScvcAEAD4DZglnDPe6c6S4mSqc72ouPqKvYT2ns0RUZJ8c8?=
 =?us-ascii?q?Pj5qpZ/4nN0F5AztF9Z5ENN+xB043AXT7Mw8N4JZSUv7OyP1r09msWaYN9VQ?=
 =?us-ascii?q?JLRf8gz/wzirUhiMhh0uba0v3UBk+T8Zbse2mqqELQ+USiE6VyavFXlG6VrI?=
 =?us-ascii?q?bFCz3PKSt1kSq5TgogzooKQ3NxMga/bNEWoDxLZqcKRymrO3EABz92gPxlyY?=
 =?us-ascii?q?cDR71JFyNG6RTCvtQyPzuczDoplslca8S/JMXqSFUoKxJp2Q8SxRR6600W7o?=
 =?us-ascii?q?l7tDyjBi6n1UI9Gb9JsWFrD//Ygsrq2LCnaUdhxdJwwESUO3QKOebo8Lih9+?=
 =?us-ascii?q?GwHabTbIuRAJULKuR14A7AVnI7eHfhloCezHLy/ww3735RzKwqIImY8laNYd?=
 =?us-ascii?q?WwnTD0nYHFFw+nRSMKqvF3rkNLhdIUHGMITnxmOkjYJ43Qbai0AgGToS90Iq?=
 =?us-ascii?q?OjHNsar5HiHzDFrMk6lLYvpPUJxgUNxzRooX79/mGNLUVqt+P3xE9YM/lERB?=
 =?us-ascii?q?6jc7P85myuCIIPeNsdjUwWqPqZHU8KtzHew/PT5sbB/ROuS4SpzuLu1Ks+Ov?=
 =?us-ascii?q?t5QgqeaopKJTYqmCshum/5SQKc9gF0bm8WAWYBY90jMgY2AUS2zIzpGsH9CF?=
 =?us-ascii?q?EAUcP2sx2uomRLef2LD36YFoP6L4wCk1WDi8UJ1x5dKq8UyakpjWhoYT16Q2?=
 =?us-ascii?q?O7xR3WnPFZK9gUmr8kBq5T0k5dA1VUaWJ17eauFjo7nJstGOsRbp83SWQpV9?=
 =?us-ascii?q?U/jqa4Rj66H9KSlUKuYQMNgdTtY6FGb84Xw2OJJoTTe5wEPBSiSAL5yYbsCJ?=
 =?us-ascii?q?fIew9+vKankHZ7Pty7moWhvBbVVw0wgBddWNJ6j9y2bqKImYdj/2+oejBsLL?=
 =?us-ascii?q?W4wK1cvcXwJxXJCS8df0gzcFMwOP1o90YiHGuEl9BaImd0d5gHKn56eANg4E?=
 =?us-ascii?q?epZM9P3iYSpf+FwyHnZxLIjvJtqFzW98SIsJRjLX+Dyh5iY0rNV6hZYWmM/W?=
 =?us-ascii?q?Pl9M2XcpX/eylTerCOIqVDlaTKs6IIcIbCM5+dUA3aZ9PqJTL0mnAN4sEp7P?=
 =?us-ascii?q?vL+nidWphG0pDEIjN+JF/wVe51l8ftgNO25RarKaxQkoEf07pvuGE66xf8PP?=
 =?us-ascii?q?ZLxOz73KnOvNJSRSKohhSim6VWA812YmVdLBRuDuM3Nt0T0qscjAJOsNxxoX?=
 =?us-ascii?q?iX2+P3ReP6SZ3P7bJQyuB14J7Qf/57ODEmWpUc3FE3V3hUppn5k0lbZXihc5?=
 =?us-ascii?q?noQDilvj7ZjkkhpU6Qdx/i+iAWTnfbL7uck29TNZzU/jXSaOlAn2dtAsNaXA?=
 =?us-ascii?q?PZx18zTvUPm9AsosIcPK0j2whIK92DIveOyOf99uTih3CucObt5NkGp52Hci?=
 =?us-ascii?q?gpRhysJtLwxYOd9+EDMpbufmAl+nGVje0HuQ8kF+R0zkrcyJ2NjOIp2vexxz?=
 =?us-ascii?q?dLQu/Jo2Ww4+Os8AsF7Xys/Ao40HxhZdniTDVM4vgBflYqjacMMKoxVPqhPt?=
 =?us-ascii?q?qjmRJ1YC/VeGsSfxUhKDVmVU+tloX8XeS2JdouK/Teb93kZIvkz7uZUZ3yMd?=
 =?us-ascii?q?jZF+sqWJpVOr8CClSGYvmcppz/r747p6OwjS6RlLxJvFv7/egAEtA6x1yfnc?=
 =?us-ascii?q?ObGzn+MVLK2iJ3QCebHJrAQcpz8b/Pt0sENe2bmD9ab1FDtUXHBXw8JXgrgZ?=
 =?us-ascii?q?79Edaey8U56Fp51Sh3SgP2Aw3ZpHkH+xMLgLdI+g3aT53J4srHhO9UFfBECr?=
 =?us-ascii?q?gP6duaVv+29uR4PJQqT08bfiUtp11B4xP1KduEOkWmSP6j+NnGhnfgYlmVg6?=
 =?us-ascii?q?GeGr1Q7zmqLfDO9UvXAqV8JyWREWRanfjENBWaqLhYmBPqs46IC91Im4+pgW?=
 =?us-ascii?q?QDGhGcHpuJLDmScMx7NuWhWzMvqXIdYcKYjIdHbTcQa/oN4jvogyUpge45W8?=
 =?us-ascii?q?UpPDqSPd34Jj6MWhs6fu+KZjAISDsyHz0U3EXi+YFsOjw8tRAWQRAFH3+h+e?=
 =?us-ascii?q?QreQAFGb/LzT8XH7UoSCM5/o0jWZarzaDIwq4WVJNglg+v1qYqKA8ru/nUOs?=
 =?us-ascii?q?088ZZRUMYwtvAvGAdtC6Mf4mylZTIVGcq5kIlZEcLFKJQtvg8WpQEWAuN/Np?=
 =?us-ascii?q?6jfIs6ozyPjYLAqV5Ge7DBjwTkdcNBytjTkBKFQAvS6S0uRdUitHRgsa2O/A?=
 =?us-ascii?q?N49MaPrvPidEC8ozrfO0zpfXLEDcVy8X9MEvKIAWqXnTVk2egdPsSc4rIUbq?=
 =?us-ascii?q?0fEuGvDJokdc9W0FIbZ1C7SNqrEtt40HTyY6VdaGJXjd0aTOiAbaV5xKVY+U?=
 =?us-ascii?q?GDHpQ6rEs3l54CgAWYvhq0ICry1OHsSu4R+zoVxl8nzX5iLAEDNg3ISydWvM?=
 =?us-ascii?q?lZ7J0ZGmCLoVJewLqmArAOQQiin8H45SVt8sJw+5xw3l8h27pQI0lAfrbrrp?=
 =?us-ascii?q?98NCRka5fvG14dgJ5uRWK1j/5+cXdOHfE+jHhXNvVSbYLvxa81cj6j2Xdb3z?=
 =?us-ascii?q?G8YhmUs2f3yGlOD0gFXUC4zcm85h4+pxPpIBGeDFcdJD3evgTiywwQFu+/p4?=
 =?us-ascii?q?lSTfMLihOBWiAf+EW9nOdNvzWpTmrF+43PCe2FMkhUC5ChjG1LqvIoIs6h2j?=
 =?us-ascii?q?Ypc+Ip2Rybkib2DU1bPgIg5vcwYLdKBYDsw2yd/5HKOayrvCF9V0zaWq58+m?=
 =?us-ascii?q?KqOskjCsiM5ZCFRVmLSPYHY1V7k3kEYEJBT8S3fq2SiKVKi8DBRkRTWgXn99?=
 =?us-ascii?q?eClfwCFWmBUN25R8Pjg61JPAgl2Aap5q/DSIUkEXKke9p9B1VYY5yCW3t06z?=
 =?us-ascii?q?T5t4mL373zss4XlOgc4lfrzW70LF4u69WQTxHay0KqSFNuxtmMC7sM+UMPzV?=
 =?us-ascii?q?NBnJYdWQZsgsXYcCKz+23a8/ZPDnOen/64tUY8wbVNlZcoEt2JBKheNJ+SSS?=
 =?us-ascii?q?YsK9qlxXjUj+6GkHNai/D7xBgM3mw/BqHzC3Bug5dAUsCXAQSLBMBpN75lRD?=
 =?us-ascii?q?djIkgZ8V+P6XpiugwlVCew0MooONnjXayDCB5vTWuE9EKm6fFjfPwKeSO3I3?=
 =?us-ascii?q?KnMP0ZuYQYyI4HWEeeZy+gJJvSJAFxlIsNrglBLMoxThGe19xBvzf4f5hmco?=
 =?us-ascii?q?SHJdS9FZAvddqPMAKmvH7YYv5DRRLYZiURm9eCOl21mhmZBxB/p03oGatA5G?=
 =?us-ascii?q?lCyuioHDuCbfWtJgO+SKmfUFAPgDjCOEZ25A4/dIzj1kvZD/9loTlaCCb0lA?=
 =?us-ascii?q?FXXVmrMAAoNq0N51r3N15tXg8gzRWy1OxQQtWBs05gfIRm3LPidu2+Fzv/2R?=
 =?us-ascii?q?3HFQIAbQpKLzhysJFcRZCATCAjnX7MIJyD+aEzamykWJE33Y2S1wnbksMiH4?=
 =?us-ascii?q?hBa6NOTak50IdmW8mltBh+DoPDEB6hkXCcAjxfyd/ZQ/jKSzMJSMJouWwWb4?=
 =?us-ascii?q?vGeykqusGOYhJuUgPiIhCDc/Qb00Q4WzsGQmge48YckIV5Xj0VnNbxjxe8eO?=
 =?us-ascii?q?mlTB5YXFN36p/7fMqrRQRoNxw6hcCdLUeMPjHxkp6FhtyerDSzeQuDGVncJV?=
 =?us-ascii?q?NSYpdAshwSqSAWL0QRiSyEz0Wbe2OaQQRor4NVzElf1jHx9BR8i6hCopaTn6?=
 =?us-ascii?q?ALHTZ/4o3IRVQ7KpEfSmh/eJ/idTxfhR90i2qKA8kmwxRTxS7lo0czHdMvTn?=
 =?us-ascii?q?1RLaSo8MNR46yo2iY5rODDA+TL+0cy1uXWbIaBoi4MIqoGiufWx6sIJtSv+P?=
 =?us-ascii?q?YNIJ45mWjSfk9FjhTSxlIJ5FujlbPzjRie/QflaU1HmRDTVUdfvJKHtHDq7l?=
 =?us-ascii?q?P+1z0nmdqjq4jvQ6BDOVM0nh2wIblhJ4qqMbUp8a8cNL+5X1ZKljPiDDYoJF?=
 =?us-ascii?q?3Y4GbS5gnygpuX1RxGblcHpzQIm7VUZD7Phfr/2kqPLgwSiReJacdjrBhVY9?=
 =?us-ascii?q?a6EnUYtXEjGKn1VjugLitap8xWxQwfjgFPHzHafma9Y7jwFK2P2qkwnbeGwO?=
 =?us-ascii?q?S5yJWBRYBlfMDUYjJ3UQfm1Rcpdmc2oXcBSvJIJ6VKaY1uXVqMc5dsdprwiC?=
 =?us-ascii?q?V1/BfMfwJKYxi52XwxwWpVyL/YJv5WChhnPNvD8Mxt9H9dwPKeeJyCUNV7Rw?=
 =?us-ascii?q?gFqE2kIihYI+Vez9HQ0aGD3k8Bq8cEf+H/f7Ll5x3iO2KjrYuRrknxV3CRJc?=
 =?us-ascii?q?Viov7l4ngSFjfYjfKfEENv9b04nbUaa6etNmYKn/sUWMcyHE70VATu7uGFdp?=
 =?us-ascii?q?jrZvfU1T+gU9+jsg7CEP+w0MFrHeOKiYfdHYop4DWv2P1EWAp0QXz+ClgwPl?=
 =?us-ascii?q?1YNjA8ZGlKB2k2vRQJLrvdWDhGBnzYNu3XB+m4zApIA4iG4eV717/6IYoKAj?=
 =?us-ascii?q?hGEWmEG3bm6C/bi2Vb+QSeO4YMba6ZN63d33TgnnlrAwjaGGnV0BcQR+vQLe?=
 =?us-ascii?q?oKKI6WE3x/FG7tHbhKvWHWpRm/QyEn98d/5i1CSzFhH92QZOPf015krwzTWR?=
 =?us-ascii?q?rv1JO50AZQhl8f8K6/G1eU1RGu70x2WHmQtt+o9Wbe0ubXi4IYAzAvLisNQN?=
 =?us-ascii?q?QrL8p03OhI3VHnRJUVUdVTI6RIyvVrxziRKgeIMivS0VFvLlFGYu+/+Mb7IX?=
 =?us-ascii?q?HFDLDZ9lXSH9M1nKd8=3D?=
X-IronPort-AV: E=Sophos;i="5.95,159,1661832000"; 
   d="scan'208";a="82002936"
Received: from mail-mw2nam10lp2105.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.105])
  by ob1.hc3370-68.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Oct 2022 22:17:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OFIbWiQz2jgiIFO9OXZPj4J/fbRgSKx4aXz3vhVBWArMRIMAGaEjlSbs6xOaJAiJaToZ957Vm2F6BuhT6xqr3prgFAlYaE5IX8+ajNn5dDXGd0xshC5WDwBe772Re0pkodVAQxr8O83knVeoNUls3WLvlSU3xf3GUGUJarSxuwnBB1fSlG5u4IuKs8gGwlB8VSqIjtF3LPQDMQd/bwTxE/gvohKxd02X5V53vzjtP5T+IMxFaBfdvpDAjar69+7WhoWmLIyctBlQCdPvasj2Z0brK9yX5a5Utd2kjz4dBpDTKLJVT5eV6PEDInQA9zFqsQFVAZYzjMbwiutVr4LZGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xobPFK6EeIsuyDlCQtFNL9N4kCXkF7EhcvqROQLcfV0=;
 b=F+euomU3rzAf8V2fvFVjGj3CSZs4ztme5SwJVjywDV4m82BxKzhhdwS2WeyCTBrp8iKuo8CaeWXabrX4kr9MlXu760tpr/ikBrtAssMrAir4Ni4GH/sm8I2q393bW6KTZXotXFyYfEUPPdWEt5dp2Yla7bPLAIvxwOagXb4qJpHM5+25LsnIXJLy3aoqubAqaMKVQXbyFa562X2ej31NKf6oDRG7OZxNp0aAnaOnbDelqo93KCosvJIYAIPbbsJ50WTYaHIMpYhiMU/cZHOnf3iVH9NbPacLtdwLDqqIZWqTlpv9Yzt/KvbDPY5aylZgCSZZzmzbsGwce7Yqa7TwXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xobPFK6EeIsuyDlCQtFNL9N4kCXkF7EhcvqROQLcfV0=;
 b=wJL4KkdEJ10svB+5lZQVWmg/32QgmJbdjbRPHNKX30GngJzmP0JMiKfJL8L5+UR0wjTdCIn1eJjNEOT4S1mSPnJplnITLlKMM45c5D3fgXNtEcuVRiJFmErlBfZJv0En4XMhsz/pDJ8WXdi6O5hwIHQJLR0MO9fc9sag6sBtHYU=
Received: from BYAPR03MB3623.namprd03.prod.outlook.com (2603:10b6:a02:aa::12)
 by SN4PR03MB6703.namprd03.prod.outlook.com (2603:10b6:806:21f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.23; Wed, 5 Oct
 2022 02:17:32 +0000
Received: from BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::988c:c9e4:ce0d:b37c]) by BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::988c:c9e4:ce0d:b37c%4]) with mapi id 15.20.5676.023; Wed, 5 Oct 2022
 02:17:32 +0000
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
Subject: Re: [PATCH v2 10/39] x86/mm: Introduce _PAGE_COW
Thread-Topic: [PATCH v2 10/39] x86/mm: Introduce _PAGE_COW
Thread-Index: AQHY2EP/xtBcdbe7Y0Ged+NmxMrKM63/ELaA
Date:   Wed, 5 Oct 2022 02:17:32 +0000
Message-ID: <54cdad9f-b810-7966-5928-9320d970a43d@citrix.com>
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
 <20220929222936.14584-11-rick.p.edgecombe@intel.com>
In-Reply-To: <20220929222936.14584-11-rick.p.edgecombe@intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR03MB3623:EE_|SN4PR03MB6703:EE_
x-ms-office365-filtering-correlation-id: 6d96bd32-77e2-4784-e062-08daa677c27d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0nYytcromVoqILULnufAReN6pP7C+Jufma3whtxFoXXv3v+nNoH1RyMOI+CDTy1RulQ7CParEvK3qTqdgCsZ1EcDTd2VmZXphfiU5Vmwx++e1ZDFZS/zVfz9xVL2Aa3K5jIgfQWJ1V2A3XGIiJxcXQkuPH+rwEaJWUL214IQA5wtNarQPckVjq8svgnbhxwxZw7PS6lcITI5o2IeXM7dg+LUf8TU4jaZy86IijxgzkadOCE+a5cMKFPoznpB8amUuBVcj3wvXqIQykENXZlhhE8uGG/cHwR2wghyrKsET5bXmvZnH417pnfZuyFR/Caa6Ccux8jEq2giesKr8/PF/dyIXQHKhX9XsM//0rkHOcCKUPU0YsRRx4DFh2/n6Gbdddt1fBjVeHC7KdQ05eAFr47Fi624GNS1JwTyOYOlgt/l3ZtV9s11pVZwwbVl3GQ/VW8llT1UNfgxTIUAiFspZyZ+Ek8de971WEo8szSJ4owG44zci9KVxxZh+N8a1fVP30Yd1ploPYf/MO/pejeRJ+Lc20LAE2Uf6ogG8pfitvgY6J5y7ArVKVRgcsJYL6EpbgpWFroOWtdQIqP3cybUr5TV/KBaw8p9ZoIkI9j64lqKAe53K26Y+BzpO4sDdcYxM3D4z+NNmSe1a5bFf/yhHzLa0rk6YCmazazw2xdLQlZyjqULvSBmKS5w9deS2edIju1aEazEBaWDielj4TB+cc+k2epC5tAkao4TVYIpyMbBkQoNvWkWQIM4knu2v3MyN7rs9Lu6d2BzILMF/ZY/6TqVqg+5u/+VoVxDnDlsM+34Etk1CoF87UxcbXz/e9jQBgBar688H9AWiVTLFy2jbS2jIvZ+iuicdFjLQDfHUrw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3623.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(366004)(396003)(39860400002)(376002)(136003)(451199015)(36756003)(6486002)(31686004)(86362001)(83380400001)(41300700001)(5660300002)(66476007)(38100700002)(122000001)(2616005)(31696002)(82960400001)(38070700005)(921005)(53546011)(186003)(6506007)(71200400001)(26005)(64756008)(66946007)(478600001)(316002)(6512007)(110136005)(66446008)(7416002)(76116006)(8936002)(8676002)(91956017)(7406005)(4326008)(66556008)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QnBKK05rNXJ1MWpRRDQ5R3hoWE5rZXExQXE5ZlluZmdhL1lHT2ZCSHd6MFRa?=
 =?utf-8?B?UnByaEYwYks3QVRNSURLR093eERiMm1DQjVic1U1bG13NjdBS01YUjZjRzkz?=
 =?utf-8?B?Q0g1bjNVVis1MjRrOStKU0Mvbm4xYlBrUU8rbnFsWlZhN20wREZJSXN6RjRV?=
 =?utf-8?B?Mko5TXVFWkhjdTl2QVlkZk81dGdOYjJESDMra01KQjY4aDYyNGoybjFCSWFY?=
 =?utf-8?B?dWhhTFF6YUw5TVZtL3FMTkRlSXl6VnZSSVlPRG1nbkxSSmFVN2lzeXFqaDNN?=
 =?utf-8?B?NWQvYjRkZjAvWkhwM2xYdXNzK0pHaDlOMllBOHBJOU9vc09HL3VKZ1FiK2c2?=
 =?utf-8?B?bDRJemZocnEvTVdqSDFHZzZRMDZiYjFYNzJ1cnBRY3JnTVJNYWh6cUFZbjhG?=
 =?utf-8?B?bjNsYjRMUDFOdFpIK2xBQ2NPWlVrdlo5TWxTV0tqQldvc0NUdDF3WXlwSEtx?=
 =?utf-8?B?ckFBdEpSUndJTmxza2dyYVhyS1BwblRRN2N3aDIvRE1sTWJ5NUhRUUI2Nnph?=
 =?utf-8?B?em0xTVQvTXEzNm9NNzRLZWlOMTVuV1kydU1nWlBnRklwY05xTklKVlhxaEZk?=
 =?utf-8?B?WG9oMzE3NXduZlVFWW5HRlhaK1JZUTJtNzk2TFZjM0RmRzYzZTNtQVBpWVAz?=
 =?utf-8?B?TjZFQktuY0xuY01IT1drekprT3ZzY1Q4aVI1S2NRNVRmZ010eWhkYjRXWEgv?=
 =?utf-8?B?V1RpcURsb3UyT2Z3M1M0TVZNS1F4RUZGaCtYOXVDQ0ovT0xTbVVQM01ZcTMr?=
 =?utf-8?B?cEhLcnllTmJyVE83UkxXTlJBUTNtRVNCdnZCR29tekhzVHVVUGJjTXlXdEFG?=
 =?utf-8?B?Y0lScTUzdUUzVHN3UExTLzNPeEFMbHlqYWZQNklNaEtNeU5meTQvQWF2bENp?=
 =?utf-8?B?MVhnL1RsMEhvaTZMenRSZGRRd0hyckVSVCsvMVExT1o2cDhHUVB5MlFIbUhk?=
 =?utf-8?B?STE5c0tDOUMwWmc5dnM5RlRQbGlxMHJmanJGdXZKYkRETGs2bXloQmFsTlh6?=
 =?utf-8?B?MFNLT2wxc09LWndDNDRJUFJLelg3OHM5aVN2Y2Z5UXd0N0djNmQvbzVEM3Vv?=
 =?utf-8?B?SVZkMU5yZ1hUdEdTcm5lZWR6TnBPeTlwNmZUbkVSM0ZtbkR4Rlh5UHRzUFFB?=
 =?utf-8?B?RVdCZktwQXc3a0Vua1hmWTAyMC83eWNHb3R0dE1aNHY4QlN2dXR6a3QzK2Rk?=
 =?utf-8?B?L3BrWWtMOFppSEZQODU1d0VZajg1Kzl2ZFVldmNwakYwU3dJOU04SlZrRGdT?=
 =?utf-8?B?ZnV6ZDFwRGVFTUk5dHFBZEFkcGd0eDY2M2FKVlZJalBHQkxUN1lhWjgxSDFX?=
 =?utf-8?B?VkxwcDFjMWwyQVBMRXk2U1N0QTZRSGwvTDUxYkxGYTFYVnJ2bXpxNHNMQjRO?=
 =?utf-8?B?MGJIMWV4a2phV1llci9wSkZZaDF2cDlKTGdXSmxGMFh4aVdHOCtYRnZyaEhE?=
 =?utf-8?B?QjRrNzBlamNLVDZaWXQzYnVwbFQ4Y0ZBeUFFVUtoaHZCUWQ4WGl3enFsVVR4?=
 =?utf-8?B?Q2NwZGtqRUl2SlFLTVpUM1ZQTk1kb01JSzNTcUZSWDFqWHZ6L3dLZTFpa1hv?=
 =?utf-8?B?VjZJeklLR25laVcyaDV6UnhSeXdPdVdCcG5zcnZyTldURUdwZDQvNnNUVTlH?=
 =?utf-8?B?WXRPQmVDdjlFS2cxdEJjZS9rL3dTdWlHTW9BNzdDbGh5b1VoaHM3WC9qVFNG?=
 =?utf-8?B?dFR5eWZkd3JtTXBldTVzbW56TlhpdEhjRW14bWtqMTFWS0JNZ1BIRFVYWGZB?=
 =?utf-8?B?MEJiSVhXWVpoM3ZORktMZ3hqam16UEQ0WktPWXMxa1BCUkpLZ2ZjTUV5RkVG?=
 =?utf-8?B?bzhFU09jbTk2Z0JBQ2N1L1VaUk1CZjBQV0lwUDZTc0dXdWsrTXFaL1JSR3pl?=
 =?utf-8?B?ZnRtTXhSODB1OXBlcUI3WVJSN3hhcE9vY3p2bzM2cUVSQ1NIa09iR0FralZ1?=
 =?utf-8?B?Z21PSFZmU2R3d1UrVE5XdWhiaWtYQ3llQlJ2QnRvMHNteUE2K0Jsc3IrSm9p?=
 =?utf-8?B?Q1hTOWtUNTdSZy9va2dVaEQ4bUVxVnNQb1FqR3E3YmpIUzNEQWdDNG1ZSm45?=
 =?utf-8?B?VkRONUdrekFqWU9sUGc0WkcveUY4ZWlZcVRnY3RudHpuSEdCUUNTYWNyMWVF?=
 =?utf-8?Q?b5zdP+/h2AdpbVfEazu0bCdDp?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <142D6060CF1CA14E9AACF332556BCAA0@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?VzRuTTJWRnc0cmpVc0hJc0lIRDJ1UE1QeThKVFBrSkRYeXp1RFdzL3ZRcHlB?=
 =?utf-8?B?bDBHRmFEM3cxcFJDS1dJVWtPNzRiTU5QYi92MVNQQkVnOWxGQ1gwT3Zxak00?=
 =?utf-8?B?WStkbW45U0tCT1FNRDNVMnV3d0xneGw3NXdBa0syejdPVXNBVEFiTUtYTEF3?=
 =?utf-8?B?dFVKdDlMTEJacitKRlNDcGRTZk5pcDdlak9zTXJZenRNN0pLaDliWHFUc3B4?=
 =?utf-8?B?SGtKbFJpbHdoS3BEcGZlaE5pYmZDcGVsYkJVejIzQXNzTnNsaDBjeCsreDVQ?=
 =?utf-8?B?czFqNkV0MWJXVDRpaWVGekJRazVxSmZHVXJiRUtWUCtuUHp5amdFWWhHM1Fu?=
 =?utf-8?B?MzdLY1gwc1o5cHFPQVBXcHdROUlpS1pIM3UvTWxyNlFzTDFOeVNCWm56cS9D?=
 =?utf-8?B?L25tQTlGWjhoVTk0RzB1TWNDMVRjTEo4ampNS01jZ00xaVc1clhka1hBZzNn?=
 =?utf-8?B?bHRzNzNPeWQxRGx5WVBydnVqekhkd3lnNVdKdXh3Vm9HK2cwcVVoS0Y2STZT?=
 =?utf-8?B?YS9MWlZCOEZHdGV5S1NiaFNQOXhFMnk0NW92Q0QzeGVFeWZscTI3SktENzdI?=
 =?utf-8?B?SVNsNzNxRnFmeDcxSktKaXhxR3NYR21UWTBLY21pc2JqWHlHNHpDQzd5aDVj?=
 =?utf-8?B?QzB2Q1BTVC9HSUZvdjJjdHRSd2dYT2U1dGNSZFVjaGt1RjNybTF3eDZJTzly?=
 =?utf-8?B?V09mTmx6UjFCSm9mNE5MbVdNbVRkZXRaMng1a1ZVby94Y2ZZalhNeGhVSUc3?=
 =?utf-8?B?VEZIUnlzYnRUZnFpeU9ZQ3I5UXBUUXBtb1JPNm10bzh3YkN0UHpDSFd3eHRM?=
 =?utf-8?B?QUg4cGhyY3U1d3JQUEFkK2RuNElwenAzNDhVN0lFQWJ0NXlsQTJySVZtcDJX?=
 =?utf-8?B?K3pGNnc0QUgzYmpIRVJPNkRSdUZlNkhVbXA2UzloMUR4NTNYeEFrODluVXA3?=
 =?utf-8?B?RTFMWTc5WkRFOVZ4SkNqWGozUU91bzZPdElrVnF6cFBEeGJ2aS8yQXFrVGFE?=
 =?utf-8?B?MzcxOE40Vnp2dFZBN2p4ZzdGaXpCVmpBdzYrdm5CNnlFQ1NmcnN4WVVoVS9O?=
 =?utf-8?B?enVmN2hxZEgwUUhuRnZ3Y05SL1d1Z3p1Q0U2dHRqWDBoMnlPYm5pTTBmb2JQ?=
 =?utf-8?B?M0JDU1JCWHV4MVd5SWlLUDd0ZDFOUkVKcEx4RTJ6LzJrdTZBOERaT01BTnY3?=
 =?utf-8?B?WkdmU1BjVHpZdVhNQVFFNklEa0FoQ1RtQzhQN21zbVZMYWZpUm93d0lnUWRx?=
 =?utf-8?B?TUpKM3dCZjVDUnFRZGFOaFA3VDZSNzdrclVsQktzRzRNU29LeWJiMnhjc2Q1?=
 =?utf-8?B?WnZZN2xrYVJVRmZwSnduNXpQVkliK29JZGRlWWt0ek1oQ2JvQXRkbWdJUy9a?=
 =?utf-8?B?SWRuanlmR3RiRWVtbEtuTDBBMGJjUjlDankvZG56T3RCNWczV0pncjlLZEJX?=
 =?utf-8?B?SCtRRWxaS1R0VGluTVB3N0c2VmkwUWxEMkZaSjRiS0UwbWovU1l5d3paUThS?=
 =?utf-8?B?YXJlTnZkbktxVlRIQTlFd2d4MTZlaXZ3NGhnU2ZwTFFaRjVXODRORlB0bEll?=
 =?utf-8?B?NnpWM0VpM0QweFFETCtrdjNEbzhrRmhKSDhtaFhwYlI1YUJFVjRhS25tZXIw?=
 =?utf-8?B?T1g1SGQ1T290QWJyV3huajAzNElXU3I0dzByZ1VxcXZOWFJsdzJsRVFVNXkr?=
 =?utf-8?B?eUl4bm1wMlpuaER4NTJyT1ZacWJHNHhlL3dXSXNrMkpwTFNqUHNlNUs3Z0U2?=
 =?utf-8?B?cVpzd2g2T1REamp3cUU0R3FFM2Ywa3lCTmhLTXl1U3B4Ty9hT1grRG5YR1M3?=
 =?utf-8?B?STVaVVB6QkZNaCt4eWd5NzBSeHJ2aWM4bm95TDJmVENlR3RuKzBwd2xlem5w?=
 =?utf-8?B?VmZONnBhS09oSWtuS0xkRnpwam1yclJJSFNtRUl1bXQ4VVBZUDdxVGxwWDJT?=
 =?utf-8?B?bmRDdmthQWxvcHZHc3VUM25SaFVtN2JvYktRcS9WQ1hiblZmYlptYVE5eFc4?=
 =?utf-8?B?VG1JRFJENHA4NGM5ODFUb1FZQ2RxZHZvSE42eEhkYVo2RHg4UEd3RHFqNHZM?=
 =?utf-8?B?bWlWTEZqNnd0ZEY4TVhCZG1LSnlFK210V0tLNWV3cnFiRVUxVVp3TmxLSi9R?=
 =?utf-8?B?TFQ1aFdxTmJjWGZsaG1yZGRveWZMdVZtc0w5TDRtVXZjYm5UZnZDZWFZVStx?=
 =?utf-8?B?OUR5YXBZQ0hxOGtjbTBtRDA0R3JZUTJyWHQwRm5Dd1FGa1lRZmV2Z1pvVloy?=
 =?utf-8?B?VnZrelY1TFAyRFhRWTRKSmR2Yzl6U1J2NTkxSUNpaUNTNG1PcmlWb3lUSGgv?=
 =?utf-8?B?eTFGN2ZjVHZTK1lVcFFxeUlNQVlDaVlKRERHTlhkVzRqTkw0WGs1YVBXdkZY?=
 =?utf-8?Q?SvzKHx4uQz6yBzYW/6zAJIsEtUxV4ciybMvbSkjjxN1Ej?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-1: RdEaV/89Y2drmXbMAl5A/gvvmKp2zBxdE/+SoyBhE78dw2EVnH3T/oAaAZ3nYIQA9tIdHCf+5tNTrvoqqHBxUXVRB2F0NVmW5pj/u66E0JvTxO2asDCtQPyrvRkGAbGBq5tQUZCgRujQ6BDfEqfKewz1f4RDdF38b+0=
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3623.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d96bd32-77e2-4784-e062-08daa677c27d
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2022 02:17:32.0538
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uyOiw3bgOpSoZme+o7cZ7IvLz1SYizHS/bFfJVAVlgrl1ckLCSGLDpVMUUrfBi+YVp4m0T5hANSOMOMdEGYfPu8bGpc81zOjWcOWl0lfl7U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR03MB6703
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gMjkvMDkvMjAyMiAyMzoyOSwgUmljayBFZGdlY29tYmUgd3JvdGU6DQo+IEZyb206IFl1LWNo
ZW5nIFl1IDx5dS1jaGVuZy55dUBpbnRlbC5jb20+DQo+DQo+IFRoZXJlIGlzIGVzc2VudGlhbGx5
IG5vIHJvb20gbGVmdCBpbiB0aGUgeDg2IGhhcmR3YXJlIFBURXMgb24gc29tZSBPU2VzDQo+IChu
b3QgTGludXgpLiBUaGF0IGxlZnQgdGhlIGhhcmR3YXJlIGFyY2hpdGVjdHMgbG9va2luZyBmb3Ig
YSB3YXkgdG8NCj4gcmVwcmVzZW50IGEgbmV3IG1lbW9yeSB0eXBlIChzaGFkb3cgc3RhY2spIHdp
dGhpbiB0aGUgZXhpc3RpbmcgYml0cy4NCj4gVGhleSBjaG9zZSB0byByZXB1cnBvc2UgYSBsaWdo
dGx5LXVzZWQgc3RhdGU6IFdyaXRlPTAsRGlydHk9MS4NCg0KSG93IGRvZXMgIlNvbWUgT1NlcyBo
YXZlIGEgZ3JlYXRlciBkZXBlbmRlbmNlIG9uIHNvZnR3YXJlIGF2YWlsYWJsZSBiaXRzDQppbiBQ
VEVzIHRoYW4gTGludXgiIHNvdW5kPw0KDQo+IFRoZSByZWFzb24gaXQncyBsaWdodGx5IHVzZWQg
aXMgdGhhdCBEaXJ0eT0xIGlzIG5vcm1hbGx5IHNldCBfYmVmb3JlXyBhDQo+IHdyaXRlLiBBIHdy
aXRlIHdpdGggYSBXcml0ZT0wIFBURSB3b3VsZCB0eXBpY2FsbHkgb25seSBnZW5lcmF0ZSBhIGZh
dWx0LA0KPiBub3Qgc2V0IERpcnR5PTEuIEhhcmR3YXJlIGNhbiAocmFyZWx5KSBib3RoIHNldCBX
cml0ZT0xICphbmQqIGdlbmVyYXRlIHRoZQ0KPiBmYXVsdCwgcmVzdWx0aW5nIGluIGEgRGlydHk9
MCxXcml0ZT0xIFBURS4gSGFyZHdhcmUgd2hpY2ggc3VwcG9ydHMgc2hhZG93DQo+IHN0YWNrcyB3
aWxsIG5vIGxvbmdlciBleGhpYml0IHRoaXMgb2RkaXR5Lg0KDQpBZ2FpbiwgYW4gaW50ZXJlc3Rp
bmcgYW5lY2RvdGUgYnV0IG5vdCBzYWxpZW50IGluZm9ybWF0aW9uIGhlcmUuDQoNCj4gZGlmZiAt
LWdpdCBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL3BndGFibGUuaCBiL2FyY2gveDg2L2luY2x1ZGUv
YXNtL3BndGFibGUuaA0KPiBpbmRleCA2NDk2ZWM4NGI5NTMuLmFkMjAxZGFlNzMxNiAxMDA2NDQN
Cj4gLS0tIGEvYXJjaC94ODYvaW5jbHVkZS9hc20vcGd0YWJsZS5oDQo+ICsrKyBiL2FyY2gveDg2
L2luY2x1ZGUvYXNtL3BndGFibGUuaA0KPiBAQCAtMTM0LDkgKzE0MiwxNyBAQCBzdGF0aWMgaW5s
aW5lIGludCBwdGVfeW91bmcocHRlX3QgcHRlKQ0KPiAgCXJldHVybiBwdGVfZmxhZ3MocHRlKSAm
IF9QQUdFX0FDQ0VTU0VEOw0KPiAgfQ0KPiAgDQo+IC1zdGF0aWMgaW5saW5lIGludCBwbWRfZGly
dHkocG1kX3QgcG1kKQ0KPiArc3RhdGljIGlubGluZSBib29sIHBtZF9kaXJ0eShwbWRfdCBwbWQp
DQo+ICB7DQo+IC0JcmV0dXJuIHBtZF9mbGFncyhwbWQpICYgX1BBR0VfRElSVFk7DQo+ICsJcmV0
dXJuIHBtZF9mbGFncyhwbWQpICYgX1BBR0VfRElSVFlfQklUUzsNCj4gK30NCj4gKw0KPiArc3Rh
dGljIGlubGluZSBib29sIHBtZF9zaHN0ayhwbWRfdCBwbWQpDQo+ICt7DQo+ICsJaWYgKCFjcHVf
ZmVhdHVyZV9lbmFibGVkKFg4Nl9GRUFUVVJFX1NIU1RLKSkNCj4gKwkJcmV0dXJuIGZhbHNlOw0K
PiArDQo+ICsJcmV0dXJuIChwbWRfZmxhZ3MocG1kKSAmIChfUEFHRV9SVyB8IF9QQUdFX0RJUlRZ
KSkgPT0gX1BBR0VfRElSVFk7DQoNCihmbGFncyAmIFBTRXxSV3xEKSA9PSBQU0V8RDsNCg0KUi9P
K0QgY2FuIGV4aXN0IGhpZ2hlciBpbiB0aGUgcGFnaW5nIHN0cnVjdHVyZXMgYW5kIGRvZXMgbm90
IGNvbnZleQ0KdHlwZT1zaHN0ay1uZXNzIHRvIGxhdGVyIHN0YWdlcyBvZiB0aGUgd2Fsay4NCg0K
DQpIb3dldmVyLCB0aGVyZSBpcyBhIGZ1cnRoZXIgY29tcGxpY2F0aW9uIHdoaWNoIGlzIGJvdW5k
IHJlYXIgaXRzIGhlYWQNCnNvb25lciBvciBsYXRlciwgYW5kIHdhcnJhbnRzIGRpc2N1c3Npbmcu
DQoNCnR5cGU9c2hzdGsgaXNuJ3QgYWN0dWFsbHkgb25seSBSL08rRCBvbiB0aGUgbGVhZiBQVEU7
IGl0cyBhbHNvIFIvVyBvbg0KdGhlIGFjY3VtdWxhdGVkIGFjY2VzcyByaWdodHMgb24gbm9uLWxl
YWYgUFRFcy4NCg0KU3BlY2lmaWNhbGx5LCBpZiB5b3UgY2xlYXIgdGhlIFJXIGJpdCBvbiBhbnkg
aGlnaGVyIGxldmVsIGluIHRoZQ0KcGFnZXRhYmxlLCB0aGVuIGV2ZXJ5dGhpbmcgbWFwcGVkIGJ5
IHRoYXQgUFRFIGNlYXNlcyB0byBiZSBvZiB0eXBlDQpzaHN0aywgZXZlbiBpZiB0aGUgbGVhZiBo
YXMgdGhlIFIvTytEIGJpdCBjb21iaW5hdGlvbi4NCg0KVGhpcyBpcyBhbGxlZ2VkbHkgYSBmZWF0
dXJlIGZvciB0aGUgZGF0YWJhc2UgZm9sa3MsIHdoZXJlIHRoZXkgY2FuDQpjcmVhdGUgUi9PIGFu
ZCBSL1cgYWxpYXNlcyBvZiB0aGUgc2FtZSBtZW1vcnksIHNoYXJpbmcgaW50ZXJtZWRpYXRlDQpw
YWdldGFibGVzLCB3aGVyZSB0aGUgUi9XIGFsaWFzIHdpbGwgc2V0IEQgYml0cyBwZXIgdXN1YWwg
YW5kIHRoZSBSL08NCmFsaWFzIG5lZWRzIG5vdCB0byB0cmFuc21vZ3JpZnkgaXRzZWxmIGludG8g
YSBzaGFkb3cgc3RhY2suDQoNCn5BbmRyZXcNCg==
